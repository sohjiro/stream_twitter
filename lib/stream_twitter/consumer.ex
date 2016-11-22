defmodule StreamTwitter.Consumer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def search(name, text), do: GenServer.cast(__MODULE__, {:search, name, text})

  def handle_cast({:search, name, text}, state) do
    Task.Supervisor.start_child(StreamTwitter.TaskSupervisor,
                                StreamTwitter.Pool.Streamer,
                                :stream,
                                [text])
    {:noreply, state}
  end

end
