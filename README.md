# Betradar UOF Schemas

[![CI](https://github.com/efcasado/betradar_uof_schemas/actions/workflows/ci.yml/badge.svg)](https://github.com/efcasado/betradar_uof_schemas/actions/workflows/ci.yml)
[![Coverage Status](https://coveralls.io/repos/github/efcasado/betradar_uof_schemas/badge.svg?branch=main)](https://coveralls.io/github/efcasado/betradar_uof_schemas?branch=main)
[![Package Version](https://img.shields.io/hexpm/v/uof_schemas.svg)](https://hex.pm/packages/uof_schemas)
[![hexdocs.pm](https://img.shields.io/badge/hex-docs-purple.svg)](https://hexdocs.pm/uof_schemas/)

Ecto embedded schemas and a generic XML decoder for Betradar's Unified Odds Feed (UOF), generated from the official [.NET SDK](https://github.com/sportradar/UnifiedOddsSdkNetCore) XSDs (pinned to `v3.11.0`). Schemas are namespaced under `UOF.Schemas.API.*` (HTTP API responses) and `UOF.Schemas.Feed.*` (AMQP feed messages).

## Installation

Add `:uof_schemas` to your dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:uof_schemas, "~> 0.1.0"} # <!-- x-release-please-version -->
  ]
end
```

## Usage

`UOF.Schemas.XML.decode/2` is the single entry point. Pass a **`root element => module` registry** to dispatch on the document's root element (dynamic), or a **schema module** to decode a known type (static). Either way it returns `{:ok, struct}` or `{:error, Ecto.Changeset.t()}`, walking the nested embeds and casting scalars (integers, decimals, datetimes, …) as it goes.

### Dynamic — the AMQP feed

The feed is a heterogeneous stream, so you dispatch on the root element. `UOF.Schemas.Feed` ships the registry; hand it to `decode/2` and it selects the matching schema — here an `odds_change`:

```elixir
xml = """
<odds_change product="1" event_id="sr:match:11830662" timestamp="1620902980000">
  <sport_event_status status="1" match_status="7" home_score="1" away_score="2"/>
  <odds>
    <market favourite="1" status="1" id="1">
      <outcome id="1" odds="1.85" active="1" probabilities="0.524431"/>
      <outcome id="2" odds="3.30" active="1" probabilities="0.286887"/>
      <outcome id="3" odds="4.65" active="1" probabilities="0.188682"/>
    </market>
  </odds>
</odds_change>
"""

{:ok, odds_change} = UOF.Schemas.XML.decode(xml, UOF.Schemas.Feed.registry())

# => %UOF.Schemas.Feed.OddsChange{
#      product: 1,
#      event_id: "sr:match:11830662",
#      timestamp: 1620902980000,
#      sport_event_status: %UOF.Schemas.Feed.SportEventStatus{
#        status: 1, match_status: 7,
#        home_score: Decimal.new("1"), away_score: Decimal.new("2"), ...
#      },
#      odds: %UOF.Schemas.Feed.OddsChangeOdds{
#        market: [
#          %UOF.Schemas.Feed.OddsChangeMarket{
#            id: 1, status: 1, favourite: 1,
#            outcome: [
#              %UOF.Schemas.Feed.OddsChangeMarketOutcome{id: "1", odds: Decimal.new("1.85"), probabilities: 0.524431, active: 1},
#              %UOF.Schemas.Feed.OddsChangeMarketOutcome{id: "2", odds: Decimal.new("3.30"), probabilities: 0.286887, active: 1},
#              %UOF.Schemas.Feed.OddsChangeMarketOutcome{id: "3", odds: Decimal.new("4.65"), probabilities: 0.188682, active: 1}
#            ]
#          }
#        ]
#      }, ...
#    }
```

### Static — an HTTP API response

When the endpoint already fixes the type, pass the schema module directly. For example, the market descriptions endpoint (`GET /v1/descriptions/{language}/markets.xml`):

```elixir
xml = """
<market_descriptions response_code="OK">
  <market id="1" name="1x2" groups="all|score|regular_play">
    <outcomes>
      <outcome id="1" name="{$competitor1}"/>
      <outcome id="2" name="draw"/>
      <outcome id="3" name="{$competitor2}"/>
    </outcomes>
  </market>
</market_descriptions>
"""

{:ok, descriptions} =
  UOF.Schemas.XML.decode(xml, UOF.Schemas.API.Descriptions.MarketDescriptions)

# => %UOF.Schemas.API.Descriptions.MarketDescriptions{
#      response_code: "OK",
#      market: [
#        %UOF.Schemas.API.Descriptions.DescMarket{
#          id: 1, name: "1x2", groups: "all|score|regular_play",
#          outcomes: %UOF.Schemas.API.Descriptions.DescOutcomes{
#            outcome: [
#              %UOF.Schemas.API.Descriptions.DescOutcomesOutcome{id: "1", name: "{$competitor1}"},
#              %UOF.Schemas.API.Descriptions.DescOutcomesOutcome{id: "2", name: "draw"},
#              %UOF.Schemas.API.Descriptions.DescOutcomesOutcome{id: "3", name: "{$competitor2}"}
#            ]
#          }, ...
#        }
#      ]
#    }
```

No single global registry is provided for the HTTP API: root element names are not unique across API groups (for example `<response>` maps to both `UOF.Schemas.API.CustomBet.Response` and `UOF.Schemas.API.Response.Response`), so callers pin the schema as above (or pass a scoped registry).

## Regenerating schemas

The modules under `lib/uof/schemas/` are generated and committed, so consumers never run codegen. To refresh them against the pinned SDK tag:

```sh
mix uof.schemas.gen   # fetch XSDs (if missing) + generate
mix format            # apply Styler to the generated modules
```

`mix uof.schemas.gen` is additive and only fetches when the cache is empty. To force a clean refresh (re-download XSDs and drop removed/renamed modules), run `make clean` first — it deletes `priv/xsd/` and the generated schema directories — then regenerate:

```sh
make clean && mix uof.schemas.gen && mix format
```

The upstream repo and pinned tag live in `codegen/xsd/sources.ex`.
