defmodule UOF.Schemas.API.Sports.PeriodScores do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:period_score, UOF.Schemas.API.Sports.CommonPeriodScore)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:period_score)
  end
end
