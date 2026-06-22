defmodule UOF.Schemas.Feed.Alive do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:product, :integer)
    field(:timestamp, :integer)
    field(:subscribed, :integer)
  end

  def changeset(struct, params) do
    cast(struct, params, [:product, :timestamp, :subscribed])
  end
end
