defmodule UOF.Schemas.API.Sports.PlayerCompetitor do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:abbreviation, :string)
    field(:nationality, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:id, :name, :abbreviation, :nationality])
  end
end
