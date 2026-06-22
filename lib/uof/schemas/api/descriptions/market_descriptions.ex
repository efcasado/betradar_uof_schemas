defmodule UOF.Schemas.API.Descriptions.MarketDescriptions do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    field(:location, :string)
    embeds_many(:market, UOF.Schemas.API.Descriptions.DescMarket)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:response_code, :location])
    |> cast_embed(:market)
  end
end
