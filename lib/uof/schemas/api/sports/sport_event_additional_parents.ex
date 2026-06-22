defmodule UOF.Schemas.API.Sports.SportEventAdditionalParents do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:parent, UOF.Schemas.API.Sports.ParentStage)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:parent)
  end
end
