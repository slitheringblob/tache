defmodule TacheWeb.CounterLive do
  use TacheWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, number: 0, diff_amount: 0)}
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
