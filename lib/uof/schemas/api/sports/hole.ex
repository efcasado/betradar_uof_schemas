defmodule UOF.Schemas.API.Sports.Hole do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:number, :integer)
    field(:par, :integer)
  end

  def changeset(struct, params) do
    cast(struct, params, [:number, :par])
  end
end
