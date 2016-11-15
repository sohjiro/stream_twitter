defmodule StreamTwitter.CLI do

  def search(text) do
    StreamTwitter.Receiver.start_link(text)
  end

end
