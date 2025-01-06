defmodule Dreambound.Repo do
  use Ecto.Repo,
    otp_app: :dreambound,
    adapter: Ecto.Adapters.Postgres
end
