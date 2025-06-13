defmodule ControleFinanceiroWeb.TransactionController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Finance
  alias ControleFinanceiro.Finance.Transaction

  action_fallback ControleFinanceiroWeb.FallbackController

  def index(conn, _params) do
    transactions = Finance.list_transactions()
    render(conn, :index, transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    user = Guardian.Plug.current_resource(conn)
    user_id = user.id

    with {:ok, %Transaction{} = transaction} <- Finance.create_transaction(transaction_params, user_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/transactions/#{transaction}")
      |> render(:show, transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Finance.get_transaction!(id)
    render(conn, :show, transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Finance.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <- Finance.update_transaction(transaction, transaction_params) do
      render(conn, :show, transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Finance.get_transaction!(id)

    with {:ok, %Transaction{}} <- Finance.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
