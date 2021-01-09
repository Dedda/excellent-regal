defmodule Regal.FileHelper do

  def is_png?(file_name) do
    String.ends_with?(file_name, ".png")
  end

  def extension(filename) do
    filename
    |> String.split(".")
    |> List.last()
  end

end