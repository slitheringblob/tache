defmodule Tache.Users do
  @moduledoc """
  this module holds the repo functions for the user schema. this will crud all user data
  """
  import Ecto.Query, warn: false
  import Ecto.Changeset

  alias Tache.Repo
  alias Tache.User

  #payload:%{"gender" => gender, "password" => password, "username" => username}
  def create_user(user_params = %{"gender" => gender, "password" => password, "username" => username}) do
    encrypted_password = Bcrypt.hash_pwd_salt(password)
    register_user_changeset(user_params)
    |> put_change(:encrypted_password, encrypted_password)
    |> Repo.insert

  end

  def register_user_changeset(params \\ %{}) do

    %User{}
    |> cast(params, [:username, :password, :gender])
    |> validate_required([:username, :password, :gender])
    |> validate_length(:password, min: 4)
  end

  def login_changeset(params \\ %{}) do
    %User{}
    |> cast(params, [:username, :password, :gender])
    |> validate_required([:username, :password])
  end

  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user by username.
  ok: %User{}
  error: Raises `Ecto.NoResultsError` if the User does not exist.
  """
  def get_user!(username), do: Repo.get_by!(User, username: username)

  def authenticate_user(username, form_password) do
    case get_user!(username) do
      user = %{} ->
          if Bcrypt.verify_pass(form_password, user.encrypted_password) do
            {:ok, User}
          else
            {:error, "User Not Found!"}
          end
      {:error, _} ->
        {:error, "User Not Found!"}
      end
    end
end
