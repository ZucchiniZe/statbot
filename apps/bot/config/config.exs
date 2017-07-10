use Mix.Config

config :logger,
  level: :info

config :nostrum,
  # dev: false,
  num_shards: :auto

import_config "secrets.exs"