defmodule UOF.Schemas.API.Descriptions.DescMatchStatusSports do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:all, :boolean)
    embeds_many(:sport, UOF.Schemas.API.Descriptions.DescMatchStatusSportsSport)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:all])
    |> cast_embed(:sport)
  end
end
