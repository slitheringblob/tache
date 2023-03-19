defmodule Tache.Tasks.Task do
  @moduledoc """
  this module has the schema-definition and the base changeset for the tasks schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, Ecto.UUID, autogenerate: true}
  schema "tasks" do
    field :status, :string
    field :title, :string
    field :user_id, :integer
    #belongs_to :user, Tache.User
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :status, :user_id])
    |> validate_required([:title, :status])
  end
end
