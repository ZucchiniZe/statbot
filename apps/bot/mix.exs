defmodule Bot.Mixfile do
  use Mix.Project

  def project do
    [app: :bot,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :nostrum],
     mod: {Bot, []}]
  end

  defp deps do
    [{:nostrum, git: "https://github.com/Kraigie/nostrum.git", branch: "staging-refactor"},
     {:tracking, in_umbrella: true},
     {:logger_file_backend, "~> 0.0.10"}]
  end
end
