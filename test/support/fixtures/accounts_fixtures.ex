defmodule ControleFinanceiro.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ControleFinanceiro.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        \: "some \\"
      })
      |> ControleFinanceiro.Accounts.create_user()

    user
  end

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        inserted_at: ~N[2025-06-10 16:28:00],
        nome: "some nome",
        senha: "some senha",
        updated_at: ~N[2025-06-10 16:28:00]
      })
      |> ControleFinanceiro.Accounts.create_user()

    user
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        nome: "some nome",
        senha: "some senha"
      })
      |> ControleFinanceiro.Accounts.create_user()

    user
  end
end
