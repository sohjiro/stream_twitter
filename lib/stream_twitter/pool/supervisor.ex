defmodule StreamTwitter.Pool.Supervisor do
  import Supervisor.Spec

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      # worker(StreamTwitter.Streamer, [])
      # supervisor(Task.Supervisor, [[name: StreamTwitter.Pool.Streamer]])
      supervisor(Task.Supervisor, [])
    ]

    # Supervisor.start_link(children, strategy: :simple_one_for_one)
    supervise(children, strategy: :simple_one_for_one)
  end

end
