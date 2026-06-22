defmodule UOF.Schemas.API.Descriptions.VoidReasonsDescriptions do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    field(:location, :string)
    embeds_many(:void_reason, UOF.Schemas.API.Descriptions.DescVoidReason)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:response_code, :location])
    |> cast_embed(:void_reason)
  end
end
