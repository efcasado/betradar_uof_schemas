defmodule UOF.Schemas.API.Sports.TeamStatistics do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    embeds_one(:statistics, UOF.Schemas.API.Sports.TeamStatisticsStatistics)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :name])
    |> cast_embed(:statistics)
  end
end
