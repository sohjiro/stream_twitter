defmodule StreamTwitter.App do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def search(text), do: GenServer.cast(__MODULE__, {:search, text})
  def count(name), do: GenServer.call(__MODULE__, {:count, name})

  def handle_cast({:search, text}, state) do
    Supervisor.start_child(StreamTwitter.Pool.Supervisor, [text])
    {:noreply, state}
  end

  def handle_call({:count, name}, _from, state) do
    {:reply, StreamTwitter.DataAccess.count(name), state}
  end

end
