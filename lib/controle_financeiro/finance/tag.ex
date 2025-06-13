defmodule ControleFinanceiro.Finance.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tags" do
    field :nome, :string

    belongs_to :user, ControleFinanceiro.Accounts.User, type: :binary_id
    many_to_many :transactions, ControleFinanceiro.Finance.Transaction, join_through: "transactions_tags", on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:nome, :user_id])
    |> validate_required([:nome, :user_id])
  end
end
