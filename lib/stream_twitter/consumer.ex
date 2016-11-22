defmodule StreamTwitter.Consumer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def search(text) do
    GenServer.cast(__MODULE__, {:search, text}) do
  end

  def handle_cast({:search, text}, state) do
    Task.Supervisor.start_child(StreamTwitter.Streamer.Supervisor,
                                StreamTwitter.Pool.Streamer,
                                :stream,
                                [text])
    {:noreply, state}
  end

end
