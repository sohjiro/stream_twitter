defmodule StreamTwitter.Streamer do
  use GenServer

  def start_link(name, text) do
    GenServer.start_link(__MODULE__, {name, text})
  end

  def init({name, text}) do
    stream = ExTwitter.stream_filter(track: text)
    StreamTwitter.DataAccess.init(name)
    {:ok, {stream, name}}
  end

  def start_stream(pid), do: GenServer.cast(pid, :start)

  def handle_cast(:start, {stream, name}) do
    for tweet <- stream, do: StreamTwitter.DataAccess.create(name, {tweet.text, tweet.created_at})
    {:noreply, {stream, name}}
  end

end
