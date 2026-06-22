defmodule UOF.Schemas.API.Sports.TournamentSeasons do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:tournament, UOF.Schemas.API.Sports.Tournament)
    embeds_one(:seasons, UOF.Schemas.API.Sports.Seasons)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:tournament)
    |> cast_embed(:seasons)
  end
end
