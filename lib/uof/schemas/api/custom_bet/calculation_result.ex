defmodule UOF.Schemas.API.CustomBet.CalculationResult do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:odds, :decimal)
    field(:probability, :decimal)
    field(:harmonization, :boolean)
  end

  def changeset(struct, params) do
    cast(struct, params, [:odds, :probability, :harmonization])
  end
end
