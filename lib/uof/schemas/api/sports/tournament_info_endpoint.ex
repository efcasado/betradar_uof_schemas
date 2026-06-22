defmodule UOF.Schemas.API.Sports.TournamentInfoEndpoint do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:tournament, UOF.Schemas.API.Sports.TournamentExtended)
    embeds_one(:season, UOF.Schemas.API.Sports.SeasonExtended)
    embeds_one(:round, UOF.Schemas.API.Sports.MatchRound)
    embeds_one(:season_coverage_info, UOF.Schemas.API.Sports.SeasonCoverageInfo)
    embeds_one(:coverage_info, UOF.Schemas.API.Sports.TournamentLiveCoverageInfo)
    embeds_one(:groups, UOF.Schemas.API.Sports.TournamentGroups)
    embeds_one(:competitors, UOF.Schemas.API.Sports.Competitors)
    embeds_one(:children, UOF.Schemas.API.Sports.Children)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:tournament)
    |> cast_embed(:season)
    |> cast_embed(:round)
    |> cast_embed(:season_coverage_info)
    |> cast_embed(:coverage_info)
    |> cast_embed(:groups)
    |> cast_embed(:competitors)
    |> cast_embed(:children)
  end
end
