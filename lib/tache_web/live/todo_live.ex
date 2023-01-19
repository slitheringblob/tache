defmodule TacheWeb.TodoLive do
  use TacheWeb, :live_view

  alias Tache.Tasks

  def mount(_params, _session, socket) do

    Tasks.subscribe()

    {:ok, reload(socket)}

  end

  def handle_info({Tasks, [:task | _], _}, socket) do
    {:noreply, reload(socket)}
  end

  #bad payload
  # ("add_task", %{"status" => %{"status" => "loading"}, "task" => %{"title" => "testing adding task"}}

  #good payload
  # handle_event("add_task", %{"task" => %{"status" => "loading", "title" => "testing adding task"}}

  def handle_event("add_task", %{"task" => input} , socket) do
    Tasks.create_task(input)
    {:noreply, reload(socket)}
  end

  defp reload(socket) do
    assign(socket, tasklist: Tasks.list_tasks())
  end
end
