defmodule UOF.Schemas.API.Sports.RaceDriverProfile do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_one(:race_driver, UOF.Schemas.API.Sports.RaceDriver)
    embeds_one(:car, UOF.Schemas.API.Sports.Car)
    embeds_one(:race_team, UOF.Schemas.API.Sports.RaceTeam)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:race_driver)
    |> cast_embed(:car)
    |> cast_embed(:race_team)
  end
end
