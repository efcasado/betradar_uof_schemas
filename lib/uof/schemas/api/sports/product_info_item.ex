defmodule UOF.Schemas.API.Sports.ProductInfoItem do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
  end

  def changeset(struct, params) do
    cast(struct, params, [])
  end
end
