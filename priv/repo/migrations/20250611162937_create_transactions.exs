defmodule ControleFinanceiro.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :descricao, :string
      add :valor, :decimal
      add :tipo, :string
      add :data, :date
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:transactions, [:user_id])
  end
end
