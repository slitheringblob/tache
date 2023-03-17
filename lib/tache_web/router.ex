defmodule TacheWeb.Router do
  use TacheWeb, :router

  import Plug.Conn

  def redirect_unauthorized(conn, _opts) do
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

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TacheWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TacheWeb.Authenticator
  end

  pipeline :restricted do
    plug :browser
    plug :redirect_unauthorized
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TacheWeb do
    pipe_through :browser

    get "/", PageController, :signup

    get "/signup", PageController, :signup
    post "/signup", PageController, :create_user

    get "/login", PageController, :login
    post "/login", PageController, :authenticate_user

    live "/counter", CounterLive, :index
    #live "/todo", TodoLive, :index
    # live "/signup", SignupLive, :index
    # live "/login", LoginLive, :index
  end

  scope "/todo", TacheWeb do
    pipe_through :restricted

    live "/", TodoLive, :index
  end

  scope "/logout", TacheWeb do
    pipe_through :browser

    get "/", LogoutController, :index
  end
  # Other scopes may use custom stacks.
  # scope "/api", TacheWeb do
  #   pipe_through :api
  # end
end
