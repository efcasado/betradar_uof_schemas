defmodule UOF.Schemas.API.Descriptions.AttributesAttribute do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:description, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:name, :description])
  end
end
