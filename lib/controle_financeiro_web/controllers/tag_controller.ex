# lib/controle_financeiro_web/controllers/tag_controller.ex
defmodule ControleFinanceiroWeb.TagController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Finance
  alias ControleFinanceiro.Finance.Tag
  alias ControleFinanceiro.Guardian

  action_fallback ControleFinanceiroWeb.FallbackController

  # GET /api/tags
  def index(conn, _params) do
    user_id = Guardian.Plug.current_resource(conn).id
    tags = Finance.list_tags(user_id)
    render(conn, :index, tags: tags)
  end

  # POST /api/tags
  def create(conn, %{"tag" => params}) do
    user_id = Guardian.Plug.current_resource(conn).id

    with {:ok, %Tag{} = tag} <- Finance.create_tag(params, user_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tags/#{tag}")
      |> render(:show, tag: tag)
    end
  end

  # GET /api/tags/:id
  def show(conn, %{"id" => id}) do
    user_id = Guardian.Plug.current_resource(conn).id
    tag = Finance.get_tag!(id, user_id)
    render(conn, :show, tag: tag)
  end

  # PUT /api/tags/:id
  def update(conn, %{"id" => id, "tag" => params}) do
    user_id = Guardian.Plug.current_resource(conn).id
    tag = Finance.get_tag!(id, user_id)

    with {:ok, %Tag{} = tag} <- Finance.update_tag(tag, params) do
      render(conn, :show, tag: tag)
    end
  end

  # DELETE /api/tags/:id
  def delete(conn, %{"id" => id}) do
    user_id = Guardian.Plug.current_resource(conn).id
    tag = Finance.get_tag!(id, user_id)

    with {:ok, %Tag{}} <- Finance.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
