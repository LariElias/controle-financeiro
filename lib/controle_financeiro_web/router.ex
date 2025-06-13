defmodule ControleFinanceiroWeb.Router do
  use ControleFinanceiroWeb, :router

  # Pipeline para requisições API
  pipeline :api do
    plug :accepts, ["json"]
  end

  # Pipeline de autenticação (deve estar funcionando via Guardian ou semelhante)
  pipeline :auth do
    plug ControleFinanceiroWeb.AuthPipeline
  end

  # Rotas públicas (sem autenticação)
  scope "/api", ControleFinanceiroWeb do
    pipe_through :api

    post "/login", AuthController, :login
    resources "/users", UserController, except: [:new, :edit]
  end

  # Rotas protegidas (com autenticação)
  scope "/api", ControleFinanceiroWeb do
    pipe_through [:api, :auth]

    resources "/transactions", TransactionController, except: [:new, :edit]
    resources "/tags", TagController, except: [:new, :edit]
  end

  # Dev routes (LiveDashboard, MailboxPreview)
  if Application.compile_env(:controle_financeiro, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ControleFinanceiroWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
