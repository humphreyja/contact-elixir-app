use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :contact, Contact.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :contact, Contact.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "contact_v1_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

import_config "oauth.secret.exs"
