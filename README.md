# Tache
Tache has a dumb counter and a todo-list built into it. You can access both from the nav bar.

## Dumb Counter
The dumb counter is just a single and multi-increment counter.

## Todo List
The todo list has a task list and state-change capabilities that is based on LiveView and Machinery. LiveView powers the frontend and Machinery implements the finite state machine that controls the transitions.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Endpoints:

| Endpoint | HTTP Method | Usage |
| :---         |     :---:      |  :---: |
| /counter   | GET | Takes you to the DumbCounter Page  |
| /todo   | GET | Takes you to the task-list page  |
