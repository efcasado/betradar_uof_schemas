defmodule UOF.Schemas.API.Descriptions.DescVariantOutcomesOutcome do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:id, :name])
  end
end
