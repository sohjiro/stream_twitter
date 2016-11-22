defmodule StreamTwitter.Pool.Streamer do

  def stream(text) do
    stream = ExTwitter.stream_filter(track: text)
    for tweet <- stream, do: StreamTwitter.DataAccess.create(text, {tweet.text, tweet.created_at})
  end

end
