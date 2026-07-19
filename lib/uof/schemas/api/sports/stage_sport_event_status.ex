defmodule UOF.Schemas.API.Sports.StageSportEventStatus do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:status, :string)
    field(:winner_id, :string)
    field(:period_of_leader, :integer)
    embeds_one(:results, UOF.Schemas.API.Sports.StageResult)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:status, :winner_id, :period_of_leader])
    |> cast_embed(:results)
  end
end
