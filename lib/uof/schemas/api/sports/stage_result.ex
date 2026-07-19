defmodule UOF.Schemas.API.Sports.StageResult do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:coverage, :string)
    embeds_many(:competitor, UOF.Schemas.API.Sports.StageResultCompetitor)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:coverage])
    |> cast_embed(:competitor)
  end
end
