defmodule UOF.Schemas.API.Sports.StageSummaryEndpoint do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:sport_event, UOF.Schemas.API.Sports.SportEvent)
    embeds_one(:sport_event_status, UOF.Schemas.API.Sports.StageSportEventStatus)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:sport_event)
    |> cast_embed(:sport_event_status)
  end
end
