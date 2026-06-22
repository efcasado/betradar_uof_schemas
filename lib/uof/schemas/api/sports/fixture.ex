defmodule UOF.Schemas.API.Sports.Fixture do
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
    field(:start_time_confirmed, :boolean)
    field(:start_time, :utc_datetime)
    embeds_one(:tournament_round, UOF.Schemas.API.Sports.MatchRound)
    embeds_one(:season, UOF.Schemas.API.Sports.SeasonExtended)
    embeds_one(:parent, UOF.Schemas.API.Sports.ParentStage)
    embeds_one(:additional_parents, UOF.Schemas.API.Sports.SportEventAdditionalParents)
    embeds_one(:tournament, UOF.Schemas.API.Sports.Tournament)
    embeds_one(:sport_event_conditions, UOF.Schemas.API.Sports.SportEventConditions)
    embeds_one(:competitors, UOF.Schemas.API.Sports.SportEventCompetitors)
    embeds_one(:races, UOF.Schemas.API.Sports.SportEventChildren)
    embeds_one(:venue, UOF.Schemas.API.Sports.Venue)
    embeds_one(:delayed_info, UOF.Schemas.API.Sports.DelayedInfo)
    embeds_one(:tv_channels, UOF.Schemas.API.Sports.TvChannels)
    embeds_one(:extra_info, UOF.Schemas.API.Sports.ExtraInfo)
    embeds_one(:coverage_info, UOF.Schemas.API.Sports.CoverageInfo)
    embeds_one(:product_info, UOF.Schemas.API.Sports.ProductInfo)
    embeds_one(:reference_ids, UOF.Schemas.API.Sports.ReferenceIds)
    embeds_one(:scheduled_start_time_changes, UOF.Schemas.API.Sports.ScheduledStartTimeChanges)
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
      :replaced_by,
      :start_time_confirmed,
      :start_time
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
    |> cast_embed(:delayed_info)
    |> cast_embed(:tv_channels)
    |> cast_embed(:extra_info)
    |> cast_embed(:coverage_info)
    |> cast_embed(:product_info)
    |> cast_embed(:reference_ids)
    |> cast_embed(:scheduled_start_time_changes)
  end
end
