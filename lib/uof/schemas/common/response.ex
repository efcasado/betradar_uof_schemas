defmodule UOF.Schemas.Common.Response do
  @moduledoc """
  The Betradar HTTP API's generic `<response>` envelope.

  Every API endpoint can return this instead of its typed payload: as an error
  body (`response_code` such as `NOT_FOUND`, with `message`/`errors`) or as the
  acknowledgement of a write/command (booking, recovery, custom-bet submit).
  Because it is shared across endpoints, it is the single root element whose name
  collides between API groups, so dynamic dispatch maps `"response"` here.

  Upstream defines it three times — `error_response.xsd` (sports API),
  `ErrorResponse.xsd` (custom bet) and `UnifiedFeedResponse.xsd` — with slightly
  different fields. This module is the hand-written **union** of those, since no
  single XSD produces it; it lives under `common/` (outside the generated `api/`
  tree) so `mix uof.schemas.gen` neither overwrites nor removes it.
  """
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    field(:action, :string)
    field(:message, :string)
    field(:generated_at, :utc_datetime)
    field(:errors, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:response_code, :action, :message, :generated_at, :errors])
  end
end
