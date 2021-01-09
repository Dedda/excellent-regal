defmodule Mix.Tasks.Regal.Cc do
  use Mix.Task

  alias Regal.Configuration
  alias Regal.TaskHelper

  def run(_) do
    TaskHelper.start_ecto()
    thumbs_dir = Configuration.get_thumbs_dir!()
    thumbs_dir
    |> File.ls!()
    |> Enum.filter(fn name -> String.ends_with?(name, ".png") end)
    |> Enum.map(fn name -> "#{thumbs_dir}/#{name}" end)
    |> Enum.each(&File.rm/1)
  end
end