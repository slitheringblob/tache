defmodule Tache.TaskStateMachine do
  @moduledoc """
  This is the state machine on which the task transitions are based.
  It has been implemented using machinery.
  """
  use Machinery,
  states: ["backlog", "inprogress", "done"],
  transitions: %{
    "backlog" => ["inprogress", "done"],
    "inprogress" => ["backlog", "done"],
    "*" => ["done"]
  }
end
