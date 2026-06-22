defmodule UOF.Schemas.API.Descriptions.DescVariant do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    embeds_one(:outcomes, UOF.Schemas.API.Descriptions.DescVariantOutcomes)
    embeds_one(:mappings, UOF.Schemas.API.Descriptions.VariantMappings)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id])
    |> cast_embed(:outcomes)
    |> cast_embed(:mappings)
  end
end
