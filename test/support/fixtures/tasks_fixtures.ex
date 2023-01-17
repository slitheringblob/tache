defmodule Tache.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tache.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        id: 42,
        status: "some status",
        title: "some title"
      })
      |> Tache.Tasks.create_task()

    task
  end
end
