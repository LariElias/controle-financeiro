defmodule ControleFinanceiroWeb.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :controle_financeiro,
    module: ControleFinanceiro.Guardian,
    error_handler: ControleFinanceiroWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
