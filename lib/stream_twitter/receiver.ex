defmodule StreamTwitter.Receiver do
  use GenServer

  def start_link(name, text) do
    GenServer.start_link(__MODULE__, text, name: name)
  end

  def init(text) do
    {:ok, pid} = StreamTwitter.Streamer.start_link(text)
    StreamTwitter.Streamer.start_stream(pid, self)
    {:ok, []}
  end

  def total(name), do: GenServer.call(name, :count)
  def tweets(name), do: GenServer.call(name, :tweets)

  def handle_call(:count, _from, tweets) do
    {:reply, length(tweets), tweets}
  end

  def handle_call(:tweets, _from, tweets) do
    {:reply, tweets, tweets}
  end

  def handle_cast({:incoming, tweet}, tweets) do
    {:noreply, [tweet | tweets]}
  end

end
