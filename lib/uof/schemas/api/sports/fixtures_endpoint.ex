defmodule UOF.Schemas.API.Sports.FixturesEndpoint do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:fixture, UOF.Schemas.API.Sports.Fixture)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:fixture)
  end
end
