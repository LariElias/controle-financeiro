defmodule ControleFinanceiro.Guardian do
  use Guardian, otp_app: :controle_financeiro

  alias ControleFinanceiro.Accounts

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user!(id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
