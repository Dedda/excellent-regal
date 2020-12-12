defmodule Regal.Scanner do

  alias Regal.Native

  @spec scan(String.t) :: tuple()
  def scan(path) do
    filters = Application.get_env(:regal, Regal.Scanner)[:filters][path]
    Native.scan(path, create_filters(filters))
  end

  defp create_filters(nil) do
    %Regal.Scanner.Filters{}
  end

  defp create_filters(map) do
    struct(Regal.Scanner.FileFilter, map)
  end

end