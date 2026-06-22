defmodule UOF.Schemas.API.Sports.MatchStatistics do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_one(:totals, UOF.Schemas.API.Sports.StatisticsTotals)
    embeds_one(:periods, UOF.Schemas.API.Sports.StatisticsPeriods)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:totals)
    |> cast_embed(:periods)
  end
end
