defmodule UOF.Schemas.FixturesTest do
  @moduledoc """
  Decodes representative XML documents through `XML.decode/1` and asserts they
  round-trip into the expected struct. The fixtures under `test/fixtures/` are
  hand-written but modelled on the shapes of the Sportradar SDK's own samples;
  they exercise the generated schemas (nested embeds and scalar casting) that
  unit tests would otherwise leave untouched.
  """
  use ExUnit.Case, async: true

  alias UOF.Schemas.API
  alias UOF.Schemas.API.Sports.Player
  alias UOF.Schemas.API.Sports.Season
  alias UOF.Schemas.Feed
  alias UOF.Schemas.XML

  @fixtures_dir Path.expand("../../fixtures", __DIR__)

  # Fixture file => the root-element struct `XML.decode/1` should dispatch to.
  @cases %{
    "feed/odds_change.xml" => Feed.OddsChange,
    "feed/bet_settlement.xml" => Feed.BetSettlement,
    "feed/bet_cancel.xml" => Feed.BetCancel,
    "feed/rollback_bet_cancel.xml" => Feed.RollbackBetCancel,
    "feed/rollback_bet_settlement.xml" => Feed.RollbackBetSettlement,
    "feed/bet_stop.xml" => Feed.BetStop,
    "feed/fixture_change.xml" => Feed.FixtureChange,
    "feed/alive.xml" => Feed.Alive,
    "feed/snapshot_complete.xml" => Feed.SnapshotComplete,
    "api/market_descriptions.xml" => API.Descriptions.MarketDescriptions,
    "api/variant_descriptions.xml" => API.Descriptions.VariantDescriptions,
    "api/match_status_descriptions.xml" => API.Descriptions.MatchStatusDescriptions,
    "api/betstop_reasons_descriptions.xml" => API.Descriptions.BetstopReasonsDescriptions,
    "api/betting_status_descriptions.xml" => API.Descriptions.BettingStatusDescriptions,
    "api/void_reasons_descriptions.xml" => API.Descriptions.VoidReasonsDescriptions,
    "api/producers.xml" => API.Descriptions.Producers,
    "api/available_selections.xml" => API.CustomBet.AvailableSelections,
    "api/calculation_response.xml" => API.CustomBet.CalculationResponse,
    "api/filtered_calculation_response.xml" => API.CustomBet.FilteredCalculationResponse,
    "api/cashout.xml" => API.Probability.Cashout,
    "api/match_summary.xml" => API.Sports.MatchSummaryEndpoint,
    "api/race_summary.xml" => API.Sports.StageSummaryEndpoint,
    "api/match_timeline.xml" => API.Sports.MatchTimelineEndpoint,
    "api/fixtures_fixture.xml" => API.Sports.FixturesEndpoint,
    "api/fixture_changes.xml" => API.Sports.FixtureChangesEndpoint,
    "api/result_changes.xml" => API.Sports.ResultChangesEndpoint,
    "api/schedule.xml" => API.Sports.ScheduleEndpoint,
    "api/sports.xml" => API.Sports.SportsEndpoint,
    "api/sport_categories.xml" => API.Sports.SportCategoriesEndpoint,
    "api/tournaments.xml" => API.Sports.TournamentsEndpoint,
    "api/tournament_info.xml" => API.Sports.TournamentInfoEndpoint,
    "api/tournament_seasons.xml" => API.Sports.TournamentSeasons,
    "api/sport_tournaments.xml" => API.Sports.SportTournamentsEndpoint,
    "api/player_profile.xml" => API.Sports.PlayerProfileEndpoint,
    "api/competitor_profile.xml" => API.Sports.CompetitorProfileEndpoint,
    "api/venue_summary.xml" => API.Sports.VenueSummaryEndpoint
  }

  describe "decode/1 over fixture documents" do
    for {path, module} <- @cases do
      test "#{path} decodes into #{inspect(module)}" do
        xml = File.read!(Path.join(@fixtures_dir, unquote(path)))

        assert {:ok, struct} = XML.decode(xml)
        assert struct.__struct__ == unquote(module)
      end
    end

    test "every fixture is covered by a case" do
      on_disk = @fixtures_dir |> Path.join("**/*.xml") |> Path.wildcard() |> Enum.sort()
      declared = @cases |> Map.keys() |> Enum.map(&Path.join(@fixtures_dir, &1)) |> Enum.sort()
      assert on_disk == declared
    end
  end

  describe "decode/2 with an explicit module" do
    # The `*Extended` variants are what the endpoints embed; their plain base
    # types (Player, Season) are never dispatched dynamically but remain valid
    # targets for the static `decode/2` path, e.g. when decoding a sub-document.
    test "decodes a base type referenced only via its Extended variant" do
      assert {:ok, %Player{id: "sr:player:10", name: "Player Ten"}} =
               XML.decode(~s(<player id="sr:player:10" name="Player Ten"/>), Player)

      assert {:ok, %Season{id: "sr:season:1", name: "2025/26"}} =
               XML.decode(~s(<season id="sr:season:1" name="2025/26"/>), Season)
    end
  end

  describe "odds_change fixture nesting" do
    setup do
      xml = File.read!(Path.join(@fixtures_dir, "feed/odds_change.xml"))
      {:ok, odds_change} = XML.decode(xml)
      %{odds_change: odds_change}
    end

    test "casts top-level scalars", %{odds_change: oc} do
      assert oc.product == 3
      assert oc.event_id == "sr:match:42"
      assert oc.timestamp == 1_653_576_646_190
    end

    test "walks the sport_event_status embeds", %{odds_change: oc} do
      ses = oc.sport_event_status
      assert ses.status == 1
      assert Decimal.equal?(ses.home_score, Decimal.new("1"))
      assert ses.clock.match_time == "71:00"
      assert [%Feed.PeriodScore{number: 1}, %Feed.PeriodScore{number: 2}] = ses.period_scores.period_score
      assert [%Feed.Result{match_status_code: 100}] = ses.results.result
      assert ses.statistics.yellow_cards.home == 2
      assert ses.statistics.corners.away == 4
    end

    test "walks the odds/market/outcome embeds", %{odds_change: oc} do
      assert [market] = oc.odds.market
      assert market.id == 1
      assert market.market_metadata.next_betstop == 1_653_576_700_000

      assert [%{id: "1", team: 1} = first, _, _] = market.outcome
      assert Decimal.equal?(first.odds, Decimal.new("2.25"))
      assert first.probabilities == 0.425694
    end
  end

  describe "race_summary fixture nesting" do
    setup do
      xml = File.read!(Path.join(@fixtures_dir, "api/race_summary.xml"))
      {:ok, race_summary} = XML.decode(xml)
      %{race_summary: race_summary}
    end

    # C-Odds (producer 14) sport events use a "codds:" prefixed id rather than
    # the usual sr:match/sr:stage urn, and are nested under a parent stage via
    # stage_type="competition_group"/"round" instead of being top-level.
    test "decodes a codds: sport event id and its parent stage", %{race_summary: rs} do
      sport_event = rs.sport_event
      assert sport_event.id == "codds:competition_group:1"
      assert sport_event.type == "child"
      assert sport_event.stage_type == "competition_group"
      assert sport_event.parent.id == "sr:stage:1"
      assert sport_event.parent.stage_type == "round"
      assert sport_event.tournament.sport.name == "Golf"
    end

    test "walks the stage sport_event_status/results/competitor embeds", %{race_summary: rs} do
      status = rs.sport_event_status
      assert status.status == "ended"
      assert status.winner_id == "sr:competitor:1"

      assert [competitor] = status.results.competitor
      assert competitor.id == "sr:competitor:1"
      assert competitor.position == 1

      assert [%{value: "4", type: "strokes", specifiers: "hole=1"}, _] = competitor.result
    end
  end
end
