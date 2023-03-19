defmodule Tache.User do
  @moduledoc """
  THis module has the schema-definition and changeset for the User Schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :encrypted_password, :string
    field :gender, :string
    field :username, :string
    field :password, :string, virtual: true
    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :gender])
    |> validate_required([:username, :password, :gender])
  end
end
