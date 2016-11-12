defmodule StreamTwitter.Streamer do

  def stream do
    receive do
      {:start, text, pid} ->
        IO.puts "starting"
        stream = ExTwitter.stream_filter(track: text)
        for tweet <- stream do
          send(pid, {:incoming, tweet.text})
        end
    end
  end

end
