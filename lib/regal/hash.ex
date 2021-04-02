defmodule Regal.Hash do
  @moduledoc false

  def hash_base16(data) do
    :crypto.hash(:sha, data)
    |> Base.encode16()
    |> String.downcase()
  end

  def hash_file(path) do
    hash_base16(File.read!(path))
  end

end
