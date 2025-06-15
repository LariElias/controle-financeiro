defmodule ControleFinanceiro.Finance.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "transactions" do
    field :descricao, :string
    field :valor, :decimal
    field :tipo, :string # "entrada" ou "saida"
    field :data, :date

    belongs_to :user, ControleFinanceiro.Accounts.User

    many_to_many :tags, ControleFinanceiro.Finance.Tag,
      join_through: "transactions_tags",
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:descricao, :valor, :tipo, :data, :user_id])
    |> validate_required([:descricao, :valor, :tipo, :data, :user_id])
    |> validate_inclusion(:tipo, ["entrada", "saida"])
    |> put_assoc_tags(attrs)
  end

  defp put_assoc_tags(changeset, %{"tag_ids" => tag_ids}) when is_list(tag_ids) do
    tags =
      ControleFinanceiro.Repo.all(
        from t in ControleFinanceiro.Finance.Tag,
        where: t.id in ^tag_ids
      )

    put_assoc(changeset, :tags, tags)
  end

  defp put_assoc_tags(changeset, _), do: changeset
end
