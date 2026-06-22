defmodule UOF.Schemas.API.Sports.ReferenceIdsReferenceId do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:value, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:name, :value])
  end
end
