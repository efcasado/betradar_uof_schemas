defmodule UOF.Schemas.Feed.Statistics do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias UOF.Schemas.Feed.StatisticsScore

  @primary_key false
  embedded_schema do
    embeds_one(:yellow_cards, StatisticsScore)
    embeds_one(:red_cards, StatisticsScore)
    embeds_one(:yellow_red_cards, StatisticsScore)
    embeds_one(:corners, StatisticsScore)
    embeds_one(:green_cards, StatisticsScore)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:yellow_cards)
    |> cast_embed(:red_cards)
    |> cast_embed(:yellow_red_cards)
    |> cast_embed(:corners)
    |> cast_embed(:green_cards)
  end
end
