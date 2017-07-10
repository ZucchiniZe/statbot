defmodule Tracking.Mixfile do
  use Mix.Project

  def project do
    [app: :tracking,
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
    [extra_applications: [:logger, :sentry],
     mod: {Tracking.Application, []}]
  end
  
  defp deps do
    [{:nostrum, git: "https://github.com/Kraigie/nostrum.git", branch: "staging-refactor"},
     {:sentry, "~> 4.0.3"}]
  end
end
