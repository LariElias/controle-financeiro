defmodule ControleFinanceiroWeb.TransactionJSON do
  def index(%{transactions: transactions}) do
    %{data: Enum.map(transactions, &data/1)}
  end

  def show(%{transaction: transaction}) do
    %{data: data(transaction)}
  end

  defp data(transaction) do
    %{
      id: transaction.id,
      descricao: transaction.descricao,
      valor: transaction.valor,
      tipo: transaction.tipo,
      data: transaction.data,
      user_id: transaction.user_id,
      tags: Enum.map(transaction.tags || [], fn tag ->
        %{
          id: tag.id,
          nome: tag.nome
        }
      end)
    }
  end
end
