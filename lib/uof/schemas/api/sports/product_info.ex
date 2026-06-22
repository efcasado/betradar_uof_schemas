defmodule UOF.Schemas.API.Sports.ProductInfo do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias UOF.Schemas.API.Sports.ProductInfoItem

  @primary_key false
  embedded_schema do
    embeds_one(:streaming, UOF.Schemas.API.Sports.StreamingChannels)
    embeds_one(:is_in_live_score, ProductInfoItem)
    embeds_one(:is_in_hosted_statistics, ProductInfoItem)
    embeds_one(:is_in_live_center_soccer, ProductInfoItem)
    embeds_one(:is_in_live_match_tracker, ProductInfoItem)
    embeds_one(:is_auto_traded, ProductInfoItem)
    embeds_one(:links, UOF.Schemas.API.Sports.ProductInfoLinks)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:streaming)
    |> cast_embed(:is_in_live_score)
    |> cast_embed(:is_in_hosted_statistics)
    |> cast_embed(:is_in_live_center_soccer)
    |> cast_embed(:is_in_live_match_tracker)
    |> cast_embed(:is_auto_traded)
    |> cast_embed(:links)
  end
end
