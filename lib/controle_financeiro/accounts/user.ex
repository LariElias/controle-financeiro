defmodule ControleFinanceiro.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :nome, :string
    field :email, :string
    field :senha, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:nome, :email, :senha])
    |> validate_required([:nome, :email, :senha])
    |> unique_constraint(:email)
    |> update_change(:senha, &Bcrypt.hash_pwd_salt/1)
  end
end
