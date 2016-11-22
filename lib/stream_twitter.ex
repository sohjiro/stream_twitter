defmodule StreamTwitter do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(StreamTwitter.Consumer, []),
      worker(StreamTwitter.DataAccess, []),
      supervisor(Task.Supervisor, [[name: StreamTwitter.Streamer.Supervisor]])
    ]

    opts = [strategy: :one_for_one, name: StreamTwitter.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
