defmodule UOF.Schemas.API.Sports.StageResultCompetitorResult do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:value, :string)
    field(:type, :string)
    field(:specifiers, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:value, :type, :specifiers])
  end
end
