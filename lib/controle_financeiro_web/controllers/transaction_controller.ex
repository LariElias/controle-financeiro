# lib/controle_financeiro_web/controllers/transaction_controller.ex
defmodule ControleFinanceiroWeb.TransactionController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Finance
  alias ControleFinanceiro.Finance.Transaction
  alias ControleFinanceiro.Guardian       # <- importante para pegar o recurso

  action_fallback ControleFinanceiroWeb.FallbackController

  # GET /api/transactions
  def index(conn, _params) do
    user_id = Guardian.Plug.current_resource(conn).id
    transactions = Finance.list_transactions(user_id)
    render(conn, :index, transactions: transactions)
  end

  # POST /api/transactions
  def create(conn, %{"transaction" => params}) do
    user_id = Guardian.Plug.current_resource(conn).id

    with {:ok, %Transaction{} = tx} <- Finance.create_transaction(params, user_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/transactions/#{tx}")
      |> render(:show, transaction: tx)
    end
  end

  # GET /api/transactions/:id
  def show(conn, %{"id" => id}) do
    user_id = Guardian.Plug.current_resource(conn).id
    tx = Finance.get_transaction!(id, user_id)
    render(conn, :show, transaction: tx)
  end

  # PUT /api/transactions/:id
  def update(conn, %{"id" => id, "transaction" => params}) do
    user_id = Guardian.Plug.current_resource(conn).id
    tx = Finance.get_transaction!(id, user_id)

    with {:ok, %Transaction{} = tx} <- Finance.update_transaction(tx, params) do
      render(conn, :show, transaction: tx)
    end
  end

  # DELETE /api/transactions/:id
  def delete(conn, %{"id" => id}) do
    user_id = Guardian.Plug.current_resource(conn).id
    tx = Finance.get_transaction!(id, user_id)

    with {:ok, %Transaction{}} <- Finance.delete_transaction(tx) do
      send_resp(conn, :no_content, "")
    end
  end
end
