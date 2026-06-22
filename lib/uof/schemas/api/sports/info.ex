defmodule UOF.Schemas.API.Sports.Info do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:key, :string)
    field(:value, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:key, :value])
  end
end
