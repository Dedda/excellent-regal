defmodule Regal.Repo do
  use Ecto.Repo,
    otp_app: :regal,
    adapter: Ecto.Adapters.Postgres
end
