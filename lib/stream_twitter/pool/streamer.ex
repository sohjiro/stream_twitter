defmodule StreamTwitter.Pool.Streamer do

  def stream(name, text) do
    StreamTwitter.DataAccess.init(name)
    stream = ExTwitter.stream_filter(track: text)
    for tweet <- stream, do: StreamTwitter.DataAccess.create(name, {tweet.text, tweet.created_at})
  end

end
