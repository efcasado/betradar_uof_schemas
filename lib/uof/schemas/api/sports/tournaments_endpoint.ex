defmodule UOF.Schemas.API.Sports.TournamentsEndpoint do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_many(:tournament, UOF.Schemas.API.Sports.TournamentExtended)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:tournament)
  end
end
