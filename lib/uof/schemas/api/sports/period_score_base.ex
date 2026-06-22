defmodule UOF.Schemas.API.Sports.PeriodScoreBase do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:type, :string)
    field(:number, :integer)
  end

  def changeset(struct, params) do
    cast(struct, params, [:type, :number])
  end
end
