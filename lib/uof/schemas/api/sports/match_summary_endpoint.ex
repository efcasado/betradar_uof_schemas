defmodule UOF.Schemas.API.Sports.MatchSummaryEndpoint do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:sport_event, UOF.Schemas.API.Sports.SportEvent)
    embeds_one(:venue, UOF.Schemas.API.Sports.Venue)
    embeds_one(:sport_event_conditions, UOF.Schemas.API.Sports.SportEventConditions)
    embeds_one(:sport_event_status, UOF.Schemas.API.Sports.SportEventStatus)
    embeds_one(:coverage_info, UOF.Schemas.API.Sports.CoverageInfo)
    embeds_one(:statistics, UOF.Schemas.API.Sports.MatchStatistics)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:sport_event)
    |> cast_embed(:venue)
    |> cast_embed(:sport_event_conditions)
    |> cast_embed(:sport_event_status)
    |> cast_embed(:coverage_info)
    |> cast_embed(:statistics)
  end
end
