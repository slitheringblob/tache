defmodule TacheWeb.RedirectUnauthorized do
  @moduledoc """
  This plug check to see whether we have the username is the conn or not. It authorizes the route to the todo-list.
  """
  import Plug.Conn
  use TacheWeb, :controller

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = Map.get(conn.assigns, :username)
    if current_user != nil do
      conn
    else
      conn
      |> put_session(:return_to, conn.request_path)
      |> redirect(to: "/login")
      |> halt()
    end
  end
end
