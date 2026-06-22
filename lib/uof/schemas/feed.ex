defmodule UOF.Schemas.Feed do
  @moduledoc """
  Betradar UOF (AMQP) feed messages.

  The feed delivers heterogeneous messages, so decoding dispatches on the root
  element via `registry/0`. Pass that registry to `UOF.Schemas.XML.decode/2`:

      UOF.Schemas.XML.decode(xml, UOF.Schemas.Feed.registry())

  The per-message schemas under `UOF.Schemas.Feed.*` are generated; this module
  is hand-written and deliberately lives *outside* the generated `feed/`
  directory so `mix uof.schemas.gen` cannot remove it.
  """

  # Root element name => generated feed schema module.
  @registry %{
    "odds_change" => __MODULE__.OddsChange,
    "bet_settlement" => __MODULE__.BetSettlement,
    "bet_stop" => __MODULE__.BetStop,
    "bet_cancel" => __MODULE__.BetCancel,
    "rollback_bet_cancel" => __MODULE__.RollbackBetCancel,
    "rollback_bet_settlement" => __MODULE__.RollbackBetSettlement,
    "fixture_change" => __MODULE__.FixtureChange,
    "alive" => __MODULE__.Alive,
    "snapshot_complete" => __MODULE__.SnapshotComplete
  }

  @doc "Maps each feed root element name to its generated schema module."
  @spec registry() :: %{optional(String.t()) => module()}
  def registry, do: @registry
end
