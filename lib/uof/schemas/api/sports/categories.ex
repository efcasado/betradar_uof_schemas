defmodule UOF.Schemas.API.Sports.Categories do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:category, UOF.Schemas.API.Sports.Category)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:category)
  end
end
