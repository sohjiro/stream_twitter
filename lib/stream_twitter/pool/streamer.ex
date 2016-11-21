defmodule StreamTwitter.Pool.Streamer do

  def stream(text) do
    stream = ExTwitter.stream_filter(track: text)
    for tweet <- stream do
      IO.puts tweet.text
    end
  end

end
