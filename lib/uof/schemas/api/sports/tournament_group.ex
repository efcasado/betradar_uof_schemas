defmodule UOF.Schemas.API.Sports.TournamentGroup do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:id, :string)
    embeds_many(:competitor, UOF.Schemas.API.Sports.Team)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :id])
    |> cast_embed(:competitor)
  end
end
