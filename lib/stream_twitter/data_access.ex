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

  def handle_cast({:insert, table_name, data}, db_name) do
    :ets.insert(db_name, {table_name, data})
    {:noreply, db_name}
  end

  # def retrieve(db_name, table_name \\ @table)
  # def retrieve(db_name, table_name), do: :ets.lookup(db_name, table_name)

end
