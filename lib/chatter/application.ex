defmodule Chatter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Vapor.Provider.Dotenv

  def set_config!() do
    providers = [%Dotenv{}]

    Vapor.load!(providers)
  end

  def start(_type, _args) do
    set_config!()

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      {
        Chatter.Repo,
        username: System.get_env("DB_USERNAME"),
        password: System.get_env("DB_PASSWORD"),
        database: System.get_env("DB_NAME"),
        hostname: System.get_env("DB_HOSTNAME"),
      },
      # Start the endpoint when the application starts
      {
        ChatterWeb.Endpoint,
        secret_key_base: System.get_env("SECRET_KEY_BASE")
      },
      {Phoenix.PubSub, [name: Chatter.PubSub, adapter: Phoenix.PubSub.PG2]}
      # Starts a worker by calling: Chatter.Worker.start_link(arg)
      # {Chatter.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chatter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ChatterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
