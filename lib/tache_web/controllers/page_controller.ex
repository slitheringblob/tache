defmodule TacheWeb.PageController do
  use TacheWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
