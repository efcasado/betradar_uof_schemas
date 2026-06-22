defmodule UOF.Schemas.API.Descriptions.Producers do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    field(:location, :string)
    embeds_many(:producer, UOF.Schemas.API.Descriptions.Producer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:response_code, :location])
    |> cast_embed(:producer)
  end
end
