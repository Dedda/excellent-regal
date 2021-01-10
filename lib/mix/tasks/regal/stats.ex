defmodule Mix.Tasks.Regal.Stats do
  use Mix.Task

  import Ecto.Query, warn: false

  alias Regal.Galleries.Gallery
  alias Regal.Galleries.Picture

  alias Regal.Configuration
  alias Regal.FileHelper
  alias Regal.Repo
  alias Regal.TaskHelper

  def run(_ \\ []) do
    Logger.configure([level: :info])
    TaskHelper.start_ecto()

    print_gallery_stats()
    print_picture_stats()
    print_thumbs_stats()
  end

  defp print_gallery_stats do
    IO.puts("#{Repo.aggregate(Gallery, :count)} galleries.")
  end

  defp print_picture_stats do
    IO.puts("#{Repo.aggregate(Picture, :count)} pictures indexed.")
  end

  defp print_thumbs_stats do
    thumbs_dir = Configuration.get_thumbs_dir!()
    thumbs = thumbs_dir
             |> File.ls!()
             |> Enum.filter(&FileHelper.is_png?/1)
             |> Enum.map(fn name -> File.stat("#{thumbs_dir}/#{name}") end)
    size = thumbs
           |> Enum.map(fn stats ->
              case stats do
                {:ok, s} -> s.size
                _ -> 0
              end
           end)
           |> Enum.sum()
    IO.puts("#{Enum.count(thumbs)} thumbnails using #{Sizeable.filesize(size)} of disk space.")
  end
end
