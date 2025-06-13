defmodule ControleFinanceiroWeb.AuthController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Accounts
  alias ControleFinanceiro.Guardian

  def login(conn, %{"email" => email, "senha" => senha}) do
    case Accounts.get_user_by_email(email) do
      nil ->
        conn |> put_status(:unauthorized) |> json(%{error: "Usuário não encontrado"})

      user ->
        case Bcrypt.verify_pass(senha, user.senha) do
          true ->
            {:ok, token, _claims} = Guardian.encode_and_sign(user)
            json(conn, %{token: token})

          false ->
            conn |> put_status(:unauthorized) |> json(%{error: "Senha incorreta"})
        end
    end
  end
end
