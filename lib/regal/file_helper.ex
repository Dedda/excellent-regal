defmodule Regal.FileHelper do

  def is_png?(filename) do
    "png" == extension(filename)
  end

  def extension(filename) do
    filename
    |> String.split("/")
    |> List.last()
    |> String.split(".")
    |> List.last()
  end

end