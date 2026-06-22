defmodule UOF.Schemas.API.Sports.CoverageInfo do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:level, :string)
    field(:live_coverage, :boolean)
    field(:covered_from, :string)
    embeds_many(:coverage, UOF.Schemas.API.Sports.Coverage)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:level, :live_coverage, :covered_from])
    |> cast_embed(:coverage)
  end
end
