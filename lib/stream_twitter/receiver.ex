defmodule StreamTwitter.Receiver do

  def start(counter, tweets) do
    receive do
      {:start} ->
        pid = spawn(StreamTwitter.Streamer, :stream, [])
        send(pid, {:start, "FelizSabado", self})
        start(counter, tweets)
      {:incoming, tweet} -> start(counter + 1, [tweet | tweets])
      {:tweets, pid} ->
        send(pid, tweets)
        start(counter + 1, tweets)
      {:count} ->
        IO.puts("counts: #{counter}")
        start(counter, tweets)
    end
  end

end
