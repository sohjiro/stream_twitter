defmodule StreamTwitter.Streamer do
  use GenServer

  def start_link(name, text) do
    IO.puts "name : #{inspect name} with text: #{text}"
    GenServer.start_link(__MODULE__, {name, text})
  end

  def init({name, text}) do
    stream = ExTwitter.stream_filter(track: text)
    create_ets(name)
    {:ok, {stream, name}}
  end

  def start_stream(pid, response_to) do
    GenServer.cast(pid, {:start, response_to})
  end

  def handle_cast({:start, _pid}, {stream, name}) do
    for tweet <- stream, do: insert_to(name, tweet.text)
    {:noreply, {stream, name}}
  end

  defp create_ets(name), do: :ets.new(name, [:bag, :protected, :named_table])
  defp insert_to(name, text), do: :ets.insert(name, {"tweets", text})

end
