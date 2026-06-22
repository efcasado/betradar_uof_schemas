defmodule UOF.Schemas.API.Sports.Car do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:chassis, :string)
    field(:engine_name, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:name, :chassis, :engine_name])
  end
end
