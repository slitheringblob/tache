defmodule TacheWeb.LoginLive do
  use TacheWeb, :live_view
  alias Tache.Users

  def mount(_params, _session, socket) do
    login_changeset = Users.login_changeset()
    {:ok, assign(socket, :login_changeset, login_changeset)}
  end

  # def handle_event("validate_user", %{"user" => user_params}, socket) do
  #   changeset = Users.login_changeset(user_params)
  #   |> Map.put(:action, :validate)

  #   {:noreply,
  #     socket
  #     |> assign(:changeset , changeset)}
  #redirect(to: "/todo")
  # end

  def handle_event("login_user", %{"user" => %{"password" => form_password, "username" => username}}, socket) do
    case Users.authenticate_user(username, form_password) do
      {:ok, _} -> {:noreply,
      socket
      |> assign(socket, username: username)
      |> push_redirect(to: "/todo", replace: true)}

      {:error, user_changeset} -> {:noreply, assign(socket, :changeset, user_changeset)}
    end
  end
end
