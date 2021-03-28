defmodule Mix.Tasks.Regal.Cleanup do
  use Mix.Task

  import Ecto.Query, warn: false

  alias Regal.Configuration
  alias Regal.FileHelper
  alias Regal.Repo

  alias Regal.Galleries.GalleryPicture
  alias Regal.Galleries.Picture

  def run(_ \\ []) do
    Logger.configure([level: :info])
    Regal.TaskHelper.start_ecto()

    delete_lose_pictures()
    delete_lose_thumbs()
  end

  defp delete_lose_pictures do
    IO.puts("\nLooking for dangling pictures...")
    found_ids = Repo.all(from p in Picture,
                         left_join: gp in GalleryPicture, on: p.id == gp.picture_id,
                         where: is_nil(gp),
                         select: p.id)
    n_found = length(found_ids)
    IO.puts("Found #{n_found} lose pictures.")
    Repo.delete_all(from p in Picture, where: p.id in ^found_ids)
  end

  defp delete_lose_thumbs do
    IO.puts("\nLooking for dangling thumbnails...")
    thumbs_dir = Configuration.get_thumbs_dir!()
    ext_ids = Repo.all(from p in Picture, select: p.external_id)
    n_deleted = File.ls!(thumbs_dir)
                |> Enum.reject(&File.dir?/1)
                |> Enum.filter(&FileHelper.is_png?/1)
                |> Enum.map(fn name -> String.slice(name, 0..-5) end)
                |> Enum.filter(fn ext_id ->
                     !Enum.member?(ext_ids, ext_id)
                   end)
                |> Enum.map(fn ext_id ->
                     File.rm(thumbs_dir <> "/" <> ext_id <> ".png")
                   end)
                |> length()
    IO.puts("Deleted #{n_deleted} thumbnails")
  end
end