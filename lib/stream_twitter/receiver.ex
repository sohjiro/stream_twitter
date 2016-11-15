defmodule StreamTwitter.Receiver do
  use GenServer

  def start_link(text) do
    GenServer.start_link(__MODULE__, text)
  end

  def init(text) do
    {:ok, pid} = StreamTwitter.Streamer.start_link(text)
    StreamTwitter.Streamer.start_stream(pid, self)
    {:ok, []}
  end

  def total(pid), do: GenServer.call(pid, :count)
  def tweets(pid), do: GenServer.call(pid, :tweets)

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
