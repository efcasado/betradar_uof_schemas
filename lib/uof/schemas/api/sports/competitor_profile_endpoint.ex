defmodule UOF.Schemas.API.Sports.CompetitorProfileEndpoint do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:competitor, UOF.Schemas.API.Sports.TeamExtended)
    embeds_one(:venue, UOF.Schemas.API.Sports.Venue)
    embeds_one(:jerseys, UOF.Schemas.API.Sports.Jerseys)
    embeds_one(:manager, UOF.Schemas.API.Sports.Manager)
    embeds_one(:players, UOF.Schemas.API.Sports.Players)
    embeds_one(:race_driver_profile, UOF.Schemas.API.Sports.RaceDriverProfile)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:competitor)
    |> cast_embed(:venue)
    |> cast_embed(:jerseys)
    |> cast_embed(:manager)
    |> cast_embed(:players)
    |> cast_embed(:race_driver_profile)
  end
end
