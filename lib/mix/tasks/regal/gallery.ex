defmodule Mix.Tasks.Regal.Gallery do
  use Mix.Task

  alias Regal.TaskHelper
  alias Regal.Galleries

  def run(args) do
    TaskHelper.start_ecto()
    TaskHelper.start_poolboy()

    if Enum.empty?(args) do
      help()
    else
      run_args(args)
    end
  end

  defp help do
    IO.puts("Please provide some more info")
  end

  defp run_args(["new" | rest]) do
    new(rest)
  end

  defp run_args(args) do
    IO.puts("I got the following args:")
    IO.inspect(args)
  end

  defp new([name]) do
    new([name, nil])
  end

  defp new([name, path]) do
    new([name, path, false])
  end

  defp new([name, path, recursive]) do
    params = %{
      name: name,
      directory: path,
      recursive: Convert.to_bool(recursive),
    }
    IO.puts("Creating new gallery '#{name}' at path '#{path}'. recursive: #{recursive}")
    Galleries.create_gallery(params, true)
  end

  defp new(_) do
    IO.puts("Wrong arguments for command 'new'. Expected: name, path \\\\ nil, recursive \\\\ false")
  end
end