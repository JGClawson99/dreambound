defmodule Dreambound.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DreamboundWeb.Telemetry,
      Dreambound.Repo,
      {DNSCluster, query: Application.get_env(:dreambound, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Dreambound.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Dreambound.Finch},
      # Start a worker by calling: Dreambound.Worker.start_link(arg)
      # {Dreambound.Worker, arg},
      # Start to serve requests, typically the last entry
      DreamboundWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dreambound.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DreamboundWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
