defmodule UOF.Schemas.API.CustomBet.FilteredMarkets do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:market, UOF.Schemas.API.CustomBet.FilteredMarket)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:market)
  end
end
