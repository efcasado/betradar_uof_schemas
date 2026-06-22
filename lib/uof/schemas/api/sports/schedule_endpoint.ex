defmodule UOF.Schemas.API.Sports.ScheduleEndpoint do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_many(:sport_event, UOF.Schemas.API.Sports.SportEvent)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:sport_event)
  end
end
