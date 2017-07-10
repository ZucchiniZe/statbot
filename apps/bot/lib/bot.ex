defmodule Bot do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    
    children = for i <- 1..System.schedulers_online, do: worker(Bot.Consumer, [], id: i)

    opts = [strategy: :one_for_one, name: Bot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
