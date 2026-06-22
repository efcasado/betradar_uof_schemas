defmodule UOF.Schemas.API.Sports.TournamentExtended do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:exhibition_games, :boolean)
    field(:scheduled, :utc_datetime)
    field(:scheduled_end, :utc_datetime)
    embeds_one(:tournament_length, UOF.Schemas.API.Sports.TournamentLength)
    embeds_one(:sport, UOF.Schemas.API.Sports.Sport)
    embeds_one(:category, UOF.Schemas.API.Sports.Category)
    embeds_one(:current_season, UOF.Schemas.API.Sports.CurrentSeason)
    embeds_one(:season_coverage_info, UOF.Schemas.API.Sports.SeasonCoverageInfo)
    embeds_one(:competitors, UOF.Schemas.API.Sports.Competitors)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :name, :exhibition_games, :scheduled, :scheduled_end])
    |> cast_embed(:tournament_length)
    |> cast_embed(:sport)
    |> cast_embed(:category)
    |> cast_embed(:current_season)
    |> cast_embed(:season_coverage_info)
    |> cast_embed(:competitors)
  end
end
