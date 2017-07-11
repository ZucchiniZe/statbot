use Mix.Config

config :logger,
  level: :error,
  backends: [:console,
             {LoggerFileBackend, :error_log},
             {LoggerFileBackend, :info_log}]

config :logger, :error_log,
  path: "logs/error.log",
  level: :error

config :logger, :info_log,
  path: "logs/info.log",
  level: :info