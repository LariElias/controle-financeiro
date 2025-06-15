defmodule ControleFinanceiro.Finance do
  @moduledoc """
  The Finance context.
  """

  import Ecto.Query, warn: false
  alias ControleFinanceiro.Repo

  alias ControleFinanceiro.Finance.Transaction
  alias ControleFinanceiro.Finance.Tag

  # ---------- Transações ----------

  @doc """
  Lista todas as transações **do usuário** (já com tags preloadadas).
  """
  # 🔄 ALTERADO: recebe user_id e faz preload(:tags)
  def list_transactions(user_id) do
    Transaction
    |> where(user_id: ^user_id)
    |> Repo.all()
    |> Repo.preload(:tags)
  end

  @doc """
  Busca uma transação específica do usuário.
  """
  # 🔄 ALTERADO: recebe user_id e faz preload(:tags)
  def get_transaction!(id, user_id) do
    Transaction
    |> where([t], t.id == ^id and t.user_id == ^user_id)
    |> Repo.one!()
    |> Repo.preload(:tags)
  end

  @doc """
  Cria uma transação já vinculada ao usuário e (opcionalmente) às tags.
  """
  # (já estava com user_id incorporado – mantemos)
  def create_transaction(attrs, user_id) do
    attrs = Map.put(attrs, "user_id", user_id)

    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Atualiza transação (pode atualizar tags enviando `"tag_ids"`).
  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Repo.preload(:tags)                    # 🔄 garante preload antes de atualizar tags
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Exclui transação.
  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  # ---------- Tags ----------

  @doc """
  Lista as tags do usuário.
  """
  # 🔄 ALTERADO: recebe user_id para isolar por dono
  def list_tags(user_id) do
    Tag
    |> where(user_id: ^user_id)
    |> Repo.all()
  end

  @doc """
  Busca tag específica do usuário.
  """
  # 🔄 ALTERADO: recebe user_id
  def get_tag!(id, user_id) do
    Tag
    |> where([t], t.id == ^id and t.user_id == ^user_id)
    |> Repo.one!()
  end

  @doc """
  Cria tag já vinculada ao usuário.
  """
  # 🔄 ALTERADO: injeta user_id
  def create_tag(attrs, user_id) do
    attrs = Map.put(attrs, "user_id", user_id)

    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Atualiza tag.
  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deleta tag.
  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end
end
