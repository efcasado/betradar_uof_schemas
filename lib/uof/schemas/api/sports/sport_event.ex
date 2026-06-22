defmodule UOF.Schemas.API.Sports.SportEvent do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:liveodds, :string)
    field(:status, :string)
    field(:next_live_time, :string)
    field(:id, :string)
    field(:name, :string)
    field(:type, :string)
    field(:stage_type, :string)
    field(:scheduled, :utc_datetime)
    field(:start_time_tbd, :boolean)
    field(:scheduled_end, :utc_datetime)
    field(:replaced_by, :string)
    embeds_one(:tournament_round, UOF.Schemas.API.Sports.MatchRound)
    embeds_one(:season, UOF.Schemas.API.Sports.SeasonExtended)
    embeds_one(:parent, UOF.Schemas.API.Sports.ParentStage)
    embeds_one(:additional_parents, UOF.Schemas.API.Sports.SportEventAdditionalParents)
    embeds_one(:tournament, UOF.Schemas.API.Sports.Tournament)
    embeds_one(:sport_event_conditions, UOF.Schemas.API.Sports.SportEventConditions)
    embeds_one(:competitors, UOF.Schemas.API.Sports.SportEventCompetitors)
    embeds_one(:races, UOF.Schemas.API.Sports.SportEventChildren)
    embeds_one(:venue, UOF.Schemas.API.Sports.Venue)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :liveodds,
      :status,
      :next_live_time,
      :id,
      :name,
      :type,
      :stage_type,
      :scheduled,
      :start_time_tbd,
      :scheduled_end,
      :replaced_by
    ])
    |> cast_embed(:tournament_round)
    |> cast_embed(:season)
    |> cast_embed(:parent)
    |> cast_embed(:additional_parents)
    |> cast_embed(:tournament)
    |> cast_embed(:sport_event_conditions)
    |> cast_embed(:competitors)
    |> cast_embed(:races)
    |> cast_embed(:venue)
  end
end
