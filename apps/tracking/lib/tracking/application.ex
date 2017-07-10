defmodule Tracking.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Tracking, [])
    ]

    opts = [strategy: :one_for_one, name: Tracking.Supervisor]
    Supervisor.start_link(children, opts)
  end
end