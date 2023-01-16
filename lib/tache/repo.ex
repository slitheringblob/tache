defmodule Tache.Repo do
  use Ecto.Repo,
    otp_app: :tache,
    adapter: Ecto.Adapters.Postgres
end
