use Mix.Config

config :logger,
  level: :info

config :nostrum,
  # dev: false,
  num_shards: :auto

config :sentry,
  enable_source_code_context: true,
  root_source_code_path: File.cwd!,
  dsn: "https://116d03fb69a64381a05fc1839e436875:46b5521a4c6b498d9c630bb311a88c49@sentry.io/189860",
  use_error_logger: true

import_config "secrets.exs"