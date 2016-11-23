defmodule StreamTwitter.Pool.Streamer do
  use GenServer

  def start_link(text) do
    GenServer.start_link(__MODULE__, text)
  end

  def init(text) do
    spawn_link(fn ->
      stream = ExTwitter.stream_filter(track: text)
      for tweet <- stream, do: StreamTwitter.DataAccess.create(text, {tweet.text, tweet.created_at})
    end)
    {:ok, text}
  end

end
