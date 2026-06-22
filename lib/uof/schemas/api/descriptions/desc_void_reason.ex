defmodule UOF.Schemas.API.Descriptions.DescVoidReason do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:description, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:id, :description])
  end
end
