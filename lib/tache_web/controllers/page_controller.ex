defmodule TacheWeb.PageController do
  use TacheWeb, :controller
  alias Tache.Users

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def signup(conn, _params) do
    changeset = Users.register_user_changeset()
    render conn, user_changeset: changeset
  end

  def login(conn, _params) do
    login_changeset = Users.login_changeset()
    render conn, login_changeset: login_changeset
  end

  def create_user(conn, %{"user"=> user_params}) do
    IO.puts "Create User Called!"

    case Users.create_user(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User Created!")
        |> redirect(to: "/login")
      {:error, user_changeset} ->
        conn
        |> put_flash(:error, "Unable to create Account!")
        |> render("signup.html", user_changeset: user_changeset)
    end
  end

  def authenticate_user(conn, %{"user" => %{"password" => form_password, "username" => username}}) do
    IO.puts "Auth User Called!"

    case Users.authenticate_user(username, form_password) do
      {:ok, _} ->
        conn
        |> put_session(:username, username)
        |> redirect(to: "/todo")
      {:error, user_changeset} ->
        conn
        |> put_flash(:error, "Unable to Login!")
        |> render("login.html", login_changeset: user_changeset)
    end
  end

end
