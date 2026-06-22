defmodule UOF.Schemas.API.Descriptions.DescMarket do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:name, :string)
    field(:groups, :string)
    field(:description, :string)
    field(:includes_outcomes_of_type, :string)
    field(:variant, :string)
    field(:outcome_type, :string)
    embeds_one(:outcomes, UOF.Schemas.API.Descriptions.DescOutcomes)
    embeds_one(:specifiers, UOF.Schemas.API.Descriptions.DescSpecifiers)
    embeds_one(:mappings, UOF.Schemas.API.Descriptions.Mappings)
    embeds_one(:attributes, UOF.Schemas.API.Descriptions.Attributes)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :id,
      :name,
      :groups,
      :description,
      :includes_outcomes_of_type,
      :variant,
      :outcome_type
    ])
    |> cast_embed(:outcomes)
    |> cast_embed(:specifiers)
    |> cast_embed(:mappings)
    |> cast_embed(:attributes)
  end
end
