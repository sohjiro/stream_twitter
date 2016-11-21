defmodule StreamTwitter do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(StreamTwitter.Consumer, []),
      supervisor(Task.Supervisor, [[name: StreamTwitter.TaskSupervisor]])
    ]

    opts = [strategy: :one_for_one, name: StreamTwitter.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
