defmodule StreamTwitter.Receiver do

  def start(counter, tweets) do
    receive do
      {:start} ->
        IO.puts "starting gen server"
        {:ok, pid} = StreamTwitter.Streamer.start_link("FelizDomingo")
        StreamTwitter.Streamer.start_stream(pid, self)
        start(counter, tweets)
      {:incoming, tweet} -> start(counter + 1, [tweet | tweets])
      {:tweets, pid} ->
        # GenServer.call(pid, tweets)
        send(pid, tweets)
        start(counter + 1, tweets)
      {:count} ->
        IO.puts("counts: #{counter}")
        start(counter, tweets)
    end
  end

end
