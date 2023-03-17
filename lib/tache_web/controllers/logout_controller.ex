defmodule TacheWeb.LogoutController do
  use TacheWeb, :controller

  import Plug.Conn

  def index(conn, _params) do
    conn
    |> clear_session()
    |> configure_session(drop: true)
    |> redirect(to: "/login")
  end
end
