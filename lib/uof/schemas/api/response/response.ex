defmodule UOF.Schemas.API.Response.Response do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    field(:action, :string)
    field(:message, :string)
  end

  def changeset(struct, params) do
    cast(struct, params, [:response_code, :action, :message])
  end
end
