defmodule ControleFinanceiro.Finance.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transactions" do
    field :descricao, :string
    field :valor, :decimal
    field :tipo, :string # "entrada" ou "saida"
    field :data, :date
    belongs_to :user, ControleFinanceiro.Accounts.User, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:descricao, :valor, :tipo, :data, :user_id])
    |> validate_required([:descricao, :valor, :tipo, :data, :user_id])
    |> validate_inclusion(:tipo, ["entrada", "saida"])
  end
end
