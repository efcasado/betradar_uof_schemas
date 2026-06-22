defmodule UOF.Schemas.API.Sports.Tournament do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:exhibition_games, :boolean)
    field(:scheduled, :utc_datetime)
    field(:scheduled_end, :utc_datetime)
    embeds_one(:tournament_length, UOF.Schemas.API.Sports.TournamentLength)
    embeds_one(:sport, UOF.Schemas.API.Sports.Sport)
    embeds_one(:category, UOF.Schemas.API.Sports.Category)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :name, :exhibition_games, :scheduled, :scheduled_end])
    |> cast_embed(:tournament_length)
    |> cast_embed(:sport)
    |> cast_embed(:category)
  end
end
