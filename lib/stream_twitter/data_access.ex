defmodule StreamTwitter.DataAccess do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    {:ok, IO.inspect(:ets.new(__MODULE__, [:bag, :protected]))}
  end

  def create(table_name, data) do
    GenServer.cast(__MODULE__, {:insert, table_name, data})
  end

  def count(table_name) do
    GenServer.call(__MODULE__, {:count, table_name})
  end

  def handle_cast({:insert, table_name, data}, db_name) do
    :ets.insert(db_name, {table_name, data})
    {:noreply, db_name}
  end

  def handle_call({:count, table_name}, _from, db_name) do
    match_spec = [{{:"$1", :_}, [{:"=:=", {:const, table_name}, :"$1"}], [true]}]
    {:reply, :ets.select_count(db_name, match_spec), db_name}
  end

end
