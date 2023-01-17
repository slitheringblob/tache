defmodule TacheWeb.CounterLive do
  use TacheWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, number: 0, diff_amount: 0)}
  end

  def render(assigns) do
    ~H"""
      <br>
      <span ><strong>Counter:</strong></span> <%= @number %> <br><br>
      <strong>Singluar Increments/Decrements</strong><br>
      <button phx-click="add">Add</button>
      <button phx-click="subtract">Subtract</button><br><br>

      <strong>Chonk Increments(Empty values default to 1)</strong>
      <.form let={f} for={:add_form} phx-submit="add_by">
        <%= text_input f, :diff_amount %>
        <button>Add </button>
      </.form>

      <strong>Chonk Decrements(Empty values default to 1)</strong>
      <.form let={f} for={:reduce_form} phx-submit="reduce_by">
        <%= text_input f, :diff_amount %>
        <button>Subtract </button>
      </.form>
      <span>(Refresh the page to reset the counter to zero!)</span>
    """
  end


  def handle_event("add", _params, socket) do
    {:noreply, assign(socket, number: socket.assigns.number + 1)}
  end

  def handle_event("subtract", _params, socket) do
    {:noreply, assign(socket, number: socket.assigns.number - 1)}
  end

  def handle_event("add_by", %{"add_form" => %{"diff_amount" => diff_amount}}, socket) do

    int_diff_amount = case Integer.parse(diff_amount) do
      {number, _} -> number
      :error -> 1
    end
    {:noreply, assign(socket, number: socket.assigns.number + int_diff_amount)}
  end

  def handle_event("reduce_by", %{"reduce_form" => %{"diff_amount" => diff_amount}}, socket) do

    int_diff_amount = case Integer.parse(diff_amount) do
      {number, _} -> number
      :error -> 1
    end
    {:noreply, assign(socket, number: socket.assigns.number - int_diff_amount)}
  end
end
