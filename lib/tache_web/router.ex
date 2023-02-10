defmodule TacheWeb.Router do
  use TacheWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TacheWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TacheWeb do
    pipe_through :browser
    get "/", PageController, :index
    live "/counter", CounterLive, :index
    live "/todo", TodoLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TacheWeb do
  #   pipe_through :api
  # end
end
