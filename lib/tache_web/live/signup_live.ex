defmodule TacheWeb.SignupLive do
  use TacheWeb, :live_view
  alias Tache.Users

  def mount(_params, _session, socket) do

    changeset = Users.register_user_changeset()
    username = ''
    assign(socket, :username, username)
    {:ok, assign(socket, :changeset, changeset)}
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      Users.register_user_changeset(user_params)
      |> Map.put(:action, :validate)

      {:noreply,
      socket
      |> assign(:changeset , changeset)}

  end

  def handle_event("create_user", %{"user" => user_params}, socket) do
    case Users.create_user(user_params) do
      {:ok, user} -> {:noreply,
      socket
      |> put_flash(:info, "User Created!")
      |> redirect(to: "/login")}

      {:error, user_changeset} -> {:noreply,
      assign(socket, :changeset, user_changeset)}
    end
  end
end
