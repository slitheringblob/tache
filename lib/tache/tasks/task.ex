defmodule Tache.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, Ecto.UUID, autogenerate: true}
  schema "tasks" do
    field :status, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :status])
    |> validate_required([:title, :status])
  end
end
