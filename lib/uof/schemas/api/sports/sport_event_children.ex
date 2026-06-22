defmodule UOF.Schemas.API.Sports.SportEventChildren do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:sport_event, UOF.Schemas.API.Sports.SportEventChildrenSportEvent)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:sport_event)
  end
end
