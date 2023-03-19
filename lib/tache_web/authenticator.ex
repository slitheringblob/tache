defmodule TacheWeb.Authenticator do
  @moduledoc """
  This module is responsible to persist the username across https and socket connections
  """
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
