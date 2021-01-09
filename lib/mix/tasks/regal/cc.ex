defmodule Mix.Tasks.Regal.Cc do
  use Mix.Task

  alias Regal.Configuration
  alias Regal.FileHelper
  alias Regal.TaskHelper

  def run(_ \\ []) do
    Logger.configure([level: :info])
    TaskHelper.start_ecto()
    thumbs_dir = Configuration.get_thumbs_dir!()
    thumbs_dir
    |> File.ls!()
    |> Enum.filter(&FileHelper.is_png?/1)
    |> Enum.map(fn name -> "#{thumbs_dir}/#{name}" end)
    |> Enum.each(&File.rm/1)
  end
end