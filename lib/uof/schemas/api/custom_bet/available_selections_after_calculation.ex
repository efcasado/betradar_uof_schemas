defmodule UOF.Schemas.API.CustomBet.AvailableSelectionsAfterCalculation do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:event, UOF.Schemas.API.CustomBet.Event)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:event)
  end
end
