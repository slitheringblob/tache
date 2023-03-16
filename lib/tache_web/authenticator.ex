defmodule TacheWeb.Authenticator do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session(conn, :username) do
      nil ->
        conn
      username ->
        assign(conn, :username, username)
    end
  end
end
