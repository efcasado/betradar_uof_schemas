defmodule UOF.Schemas.API.Sports.Tournaments do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:tournament, UOF.Schemas.API.Sports.Tournament)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:tournament)
  end
end
