defmodule UOF.Schemas.API.Sports.TournamentLiveCoverageInfo do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:live_coverage, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:live_coverage])
  end
end
