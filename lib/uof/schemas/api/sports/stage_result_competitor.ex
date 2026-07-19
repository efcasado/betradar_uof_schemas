defmodule UOF.Schemas.API.Sports.StageResultCompetitor do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:position, :integer)
    field(:points, :float)
    field(:distance, :float)
    field(:wc_points, :float)
    field(:time, :string)
    field(:time_ranking, :integer)
    field(:status, :string)
    field(:status_comment, :string)
    field(:sprint, :float)
    field(:sprint_ranking, :integer)
    field(:climber, :float)
    field(:climber_ranking, :integer)
    field(:grid, :integer)
    embeds_many(:result, UOF.Schemas.API.Sports.StageResultCompetitorResult)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :id,
      :position,
      :points,
      :distance,
      :wc_points,
      :time,
      :time_ranking,
      :status,
      :status_comment,
      :sprint,
      :sprint_ranking,
      :climber,
      :climber_ranking,
      :grid
    ])
    |> cast_embed(:result)
  end
end
