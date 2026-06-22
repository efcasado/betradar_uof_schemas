defmodule UOF.Schemas.API.Sports.EventPlayerAssist do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:method, :string)
    field(:bench, :string)
    field(:type, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:id, :name, :method, :bench, :type])
  end
end
