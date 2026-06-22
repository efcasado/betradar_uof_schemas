defmodule UOF.Schemas.API.Sports.PlayerExtendedList do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:player, UOF.Schemas.API.Sports.PlayerCompetitor)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:player)
  end
end
