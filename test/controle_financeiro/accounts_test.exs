defmodule ControleFinanceiro.AccountsTest do
  use ControleFinanceiro.DataCase

  alias ControleFinanceiro.Accounts

  describe "users" do
    alias ControleFinanceiro.Accounts.User

    import ControleFinanceiro.AccountsFixtures

    @invalid_attrs %{"\\": nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{"\\": "some \\"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.\ == "some \\"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{"\\": "some updated \\"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.\ == "some updated \\"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "users" do
    alias ControleFinanceiro.Accounts.User

    import ControleFinanceiro.AccountsFixtures

    @invalid_attrs %{nome: nil, email: nil, senha: nil, inserted_at: nil, updated_at: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{nome: "some nome", email: "some email", senha: "some senha", inserted_at: ~N[2025-06-10 16:28:00], updated_at: ~N[2025-06-10 16:28:00]}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.nome == "some nome"
      assert user.email == "some email"
      assert user.senha == "some senha"
      assert user.inserted_at == ~N[2025-06-10 16:28:00]
      assert user.updated_at == ~N[2025-06-10 16:28:00]
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{nome: "some updated nome", email: "some updated email", senha: "some updated senha", inserted_at: ~N[2025-06-11 16:28:00], updated_at: ~N[2025-06-11 16:28:00]}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.nome == "some updated nome"
      assert user.email == "some updated email"
      assert user.senha == "some updated senha"
      assert user.inserted_at == ~N[2025-06-11 16:28:00]
      assert user.updated_at == ~N[2025-06-11 16:28:00]
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "users" do
    alias ControleFinanceiro.Accounts.User

    import ControleFinanceiro.AccountsFixtures

    @invalid_attrs %{nome: nil, email: nil, senha: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{nome: "some nome", email: "some email", senha: "some senha"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.nome == "some nome"
      assert user.email == "some email"
      assert user.senha == "some senha"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{nome: "some updated nome", email: "some updated email", senha: "some updated senha"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.nome == "some updated nome"
      assert user.email == "some updated email"
      assert user.senha == "some updated senha"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
