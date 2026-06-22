defmodule UOF.Schemas.API.Descriptions.DescMatchStatus do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:description, :string)
    field(:period_number, :integer)
    embeds_one(:sports, UOF.Schemas.API.Descriptions.DescMatchStatusSports)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :description, :period_number])
    |> cast_embed(:sports)
  end
end
