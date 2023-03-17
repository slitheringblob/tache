defmodule TacheWeb.TodoLive do
  @moduledoc """
  this module contains the handlers for the todo application. This module is responsible for mounting, rendering, and handling all task related events.
  """
  use TacheWeb, :live_view

  alias Tache.Tasks
  alias Tache.TaskStateMachine

  @doc """
  mounts the socket to the lv and sets the state variable for transitions
  """
  def mount(params, session, socket) do
    IO.inspect session
    Tasks.subscribe()
    {:ok, username} = Map.fetch(session, "username")
    socket = assign(socket, :invalid_transition, false)
    socket = assign(socket, :username, username)
    {:ok, reload(socket)}

  end


  @doc """
  This module just reloads the socket with the list of tasks

  # payload for handle_info
  # TacheWeb.TodoLive.handle_info({Tache.Tasks, [:task, :updated], %Tache.Tasks.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, uuid: "18202efe-60af-4120-a9a7-74cf03fdc870", status: "inprogress", title: "tabletest", inserted_at: ~N[2023-01-24 09:57:42], updated_at: ~N[2023-02-08 10:08:24]}}
  """

  def handle_info({Tasks, [:task | _], _}, socket) do
    {:noreply, reload(socket)}
  end

  @doc """
  this module is responsible for handling the add_task event.
  It adds a task to the database with the name and status of the task.

  # bad payload
  # ("add_task", %{"status" => %{"status" => "loading"}, "task" => %{"title" => "testing adding task"}}

  # good payload
  # handle_event("add_task", %{"task" => %{"status" => "loading", "title" => "testing adding task"}}
  """
  def handle_event("add_task", %{"task" => input} , socket) do
    Tasks.create_task(input)
    {:noreply, reload(socket)}
  end

  def handle_event("mark_as_done", %{"id" => id} , socket) do
    task_to_update = Tasks.get_task!(id)
    Tasks.update_task(task_to_update, %{status: "done"})
    {:noreply, reload(socket)}
  end

  def handle_event("handle_state_change", %{"button-name" => btn_name, "task-id" => id}, socket) do
    task_by_id = Tasks.get_task!(id)
    new_status = btn_name
    #invalid_transition_state = socket.assigns.invalid_transition
    case Machinery.transition_to(task_by_id, TaskStateMachine, new_status) do
      {:error, _} ->
        socket = assign(socket, invalid_transition: true)
        {:noreply, reload(socket)}

      {:ok, _} ->
        Tasks.update_task(task_by_id, %{status: new_status})
        socket = assign(socket, invalid_transition: false)
        {:noreply, reload(socket)}

      end
  end

  defp reload(socket) do
    assign(socket, tasklist: Tasks.list_tasks())
  end

end
