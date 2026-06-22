defmodule UOF.Schemas.API.CustomBet.Market do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:specifiers, :string)
    embeds_many(:outcome, UOF.Schemas.API.CustomBet.Outcome)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :specifiers])
    |> cast_embed(:outcome)
  end
end
