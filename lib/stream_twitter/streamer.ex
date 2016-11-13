defmodule StreamTwitter.Streamer do
  use GenServer

  def start_link(text) do
    stream = ExTwitter.stream_filter(track: text)
    GenServer.start_link(__MODULE__, stream)
  end

  def start_stream(pid, response_to) do
    GenServer.cast(pid, {:start, response_to})
  end

  def handle_cast({:start, pid}, stream) do
    for tweet <- stream do
      send(pid, {:incoming, tweet.text})
      # GenServer.call(pid, {:incoming, tweet.text})
    end
  end

end
