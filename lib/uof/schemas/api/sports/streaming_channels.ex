defmodule UOF.Schemas.API.Sports.StreamingChannels do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:channel, UOF.Schemas.API.Sports.StreamingChannel)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:channel)
  end
end
