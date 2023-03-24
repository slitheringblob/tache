defmodule TacheWeb.LogoutController do
  @moduledoc """
  this has been deprecated and moved to the PageController.
  """
  use TacheWeb, :controller

  import Plug.Conn

  def index(conn, _params) do
    conn
    |> clear_session()
    |> configure_session(drop: true)
    |> redirect(to: "/login")
  end
end
