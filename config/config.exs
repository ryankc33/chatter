# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chatter,
  ecto_repos: [Chatter.Repo]

# Configures the endpoint
config :chatter, ChatterWeb.Endpoint,
  url: [host: "localhost"],
  # secret_key_base: "X0a2WNZJaAavTDMS6hrSPkpNYMGafzlChynad5dyHlhG5U7B8vVWfU74SDWEbuy1",
  render_errors: [view: ChatterWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Chatter.PubSub,
  live_view: [signing_salt: System.get_env("LIVEVIEW_SALT")]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
