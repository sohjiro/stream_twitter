defmodule StreamTwitter.DataAccess do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    {:ok, :ets.new(__MODULE__, [:bag, :protected])}
  end

  def create(table_name, data) do
    GenServer.cast(__MODULE__, {:insert, table_name, data})
  end

  def retrieve(table_name) do
    GenServer.cast(__MODULE__, {:retrieve, table_name})
  end

  def handle_cast({:insert, table_name, data}, db_name) do
    :ets.insert(db_name, {table_name, data})
    {:noreply, db_name}
  end

  def handle_call({:retrieve, table_name}, db_name) do
    {:reply, :ets.lookup(db_name, table_name), db_name}
  end

end
