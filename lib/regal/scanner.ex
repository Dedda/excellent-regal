defmodule Regal.Scanner do

  alias Regal.Native

  @spec scan(String.t, %Regal.Scanner.Filters{}) :: tuple()
  def scan(path, filters) do
    Native.scan(path, filters)
  end

end