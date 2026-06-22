defmodule UOF.Schemas.API.Sports.VenueSummaryEndpoint do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:venue, UOF.Schemas.API.Sports.Venue)
    embeds_one(:home_teams, UOF.Schemas.API.Sports.HomeTeams)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:venue)
    |> cast_embed(:home_teams)
  end
end
