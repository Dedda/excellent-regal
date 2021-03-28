defmodule Mix.Tasks.Regal.Stats do
  use Mix.Task

  import Ecto.Query, warn: false

  alias Regal.Galleries.Gallery
  alias Regal.Galleries.Picture

  alias Regal.Repo
  alias Regal.Statistics
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
    thumbs_count = Statistics.thumbs_count()
    thumbs_disk_usage = Statistics.thumbs_disk_usage()
    IO.puts("#{thumbs_count} thumbnails using #{Sizeable.filesize(thumbs_disk_usage)} of disk space.")
  end
end
