defmodule ControleFinanceiroWeb.TagJSON do
  def index(%{tags: tags}) do
    %{data: Enum.map(tags, &data/1)}
  end

  def show(%{tag: tag}) do
    %{data: data(tag)}
  end

  defp data(tag) do
    %{
      id: tag.id,
      nome: tag.nome,
      user_id: tag.user_id
    }
  end
end
