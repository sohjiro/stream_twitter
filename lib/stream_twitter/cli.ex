defmodule StreamTwitter.CLI do

  def search(text) do
    ExTwitter.stream_filter(track: text)
    |> Stream.map(fn(x) -> x.text end)
    |> Stream.map(fn(x) -> IO.puts "#{x}\n---------------\n" end)
    |> Enum.to_list
  end

end
