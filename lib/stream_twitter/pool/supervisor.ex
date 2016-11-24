defmodule StreamTwitter.Pool.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    children = [
      worker(StreamTwitter.Pool.Streamer, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

end
