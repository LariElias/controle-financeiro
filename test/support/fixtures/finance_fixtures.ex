defmodule ControleFinanceiro.FinanceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ControleFinanceiro.Finance` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        data: ~N[2025-06-10 16:29:00],
        descricao: "some descricao",
        tipo: "some tipo",
        valor: "120.5"
      })
      |> ControleFinanceiro.Finance.create_transaction()

    transaction
  end

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        nome: "some nome"
      })
      |> ControleFinanceiro.Finance.create_tag()

    tag
  end
end
