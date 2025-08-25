defmodule AmadeusExplorer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AmadeusExplorerWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:amadeus_explorer, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AmadeusExplorer.PubSub},
      # Start a worker by calling: AmadeusExplorer.Worker.start_link(arg)
      # {AmadeusExplorer.Worker, arg},
      # Start to serve requests, typically the last entry
      AmadeusExplorerWeb.Endpoint,
      AmadeusExplorer.WalletsCache,
      {AmadeusExplorer.EpochsCache, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AmadeusExplorer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AmadeusExplorerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
