defmodule UOF.Schemas.API.Sports.Coverage do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:includes, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:includes])
  end
end
