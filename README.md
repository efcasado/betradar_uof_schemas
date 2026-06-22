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

`UOF.Schemas.XML.decode/2` is the single entry point. Pass a **schema module** to decode a known type (static), or a **`root element => module` registry** to dispatch on the document's root element (dynamic).

Static — an HTTP API response, where the endpoint already fixes the type:

```elixir
{:ok, %UOF.Schemas.API.Users.BookmakerDetails{} = details} =
  UOF.Schemas.XML.decode(xml, UOF.Schemas.API.Users.BookmakerDetails)
```

Dynamic — the heterogeneous AMQP feed. `UOF.Schemas.Feed` ships the registry; pass it to `decode/2`:

```elixir
{:ok, %UOF.Schemas.Feed.OddsChange{}} =
  UOF.Schemas.XML.decode(xml, UOF.Schemas.Feed.registry())
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
