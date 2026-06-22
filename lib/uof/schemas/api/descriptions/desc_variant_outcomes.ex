defmodule UOF.Schemas.API.Descriptions.DescVariantOutcomes do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:outcome, UOF.Schemas.API.Descriptions.DescVariantOutcomesOutcome)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:outcome)
  end
end
