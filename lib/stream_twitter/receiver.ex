defmodule StreamTwitter.Receiver do
  use GenServer

  def start_link(name, text) do
    GenServer.start_link(__MODULE__, {name, text}, name: name)
  end

  def init({name, text}) do
    {:ok, pid} = StreamTwitter.Streamer.start_link(name, text)
    StreamTwitter.Streamer.start_stream(pid)
    {:ok, name}
  end

  def total(name), do: GenServer.call(name, :count)
  def tweets(name), do: GenServer.call(name, :tweets)

  def handle_call(:count, _from, db_name) do
    tweets = StreamTwitter.DataAccess.retrieve(db_name)
    {:reply, length(tweets), db_name}
  end

  def handle_call(:tweets, _from, db_name) do
    {:reply, StreamTwitter.DataAccess.retrieve(db_name), db_name}
  end

end
