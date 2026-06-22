defmodule UOF.Schemas.API.Descriptions.DescOutcomesOutcome do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:description, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:id, :name, :description])
  end
end
