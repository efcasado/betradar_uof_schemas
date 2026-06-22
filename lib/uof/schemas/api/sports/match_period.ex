defmodule UOF.Schemas.API.Sports.MatchPeriod do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:name, :string)
    embeds_many(:teams, UOF.Schemas.API.Sports.StatisticsTeam)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name])
    |> cast_embed(:teams)
  end
end
