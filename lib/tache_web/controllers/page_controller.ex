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
    render conn
  end

  def create_user(conn, %{} = user_params) do
    IO.puts "Create User Called!"
    IO.inspect user_params

    render conn
  end

end
