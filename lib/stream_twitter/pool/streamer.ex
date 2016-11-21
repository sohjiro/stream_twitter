defmodule StreamTwitter.Pool.Streamer do

  def stream do
    stream = ExTwitter.stream_filter(track: "apple")
    for tweet <- stream do
      IO.puts tweet.text
    end
  end

end
