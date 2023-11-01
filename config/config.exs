# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :github_api,
  ecto_repos: [GithubApi.Repo],
  generators: [timestamp_type: :utc_datetime]

config :github_api, GithubApiWeb.ReposController, github_client_adapter: GithubApi.Github.Client

config :github_api, GithubApi.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Guardian
config :github_api, GithubApiWeb.Auth.Guardian,
  issuer: "github_api",
  secret_key: "ssWQF3Z2LzZph4yvS8YpiyRafE4nZDU2Dh7RK/zgRA88TbpTqoBp3c8EWItX8JSv"

# Configures the endpoint
config :github_api, GithubApiWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: GithubApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: GithubApi.PubSub,
  live_view: [signing_salt: "gfG8srI+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
