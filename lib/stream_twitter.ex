defmodule StreamTwitter do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(StreamTwitter.Receiver, [])
    ]

    opts = [strategy: :simple_one_for_one, name: StreamTwitter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def search(name, text), do: Supervisor.start_child(StreamTwitter.Supervisor, [name, text])
  def total(name), do: StreamTwitter.Receiver.total(name)
  def tweets(name), do: StreamTwitter.Receiver.tweets(name)

end
