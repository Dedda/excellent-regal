defmodule Regal.Scanner do

  import Regal.FileHelper
  import Regal.Hash

  alias Regal.Configuration
  alias Regal.Native
  alias Regal.Galleries
  alias Regal.Galleries.Gallery
  alias Regal.Galleries.Picture

  @valid_extensions ["png", "jpg", "jpeg"]

  def index_gallery(%Gallery{} = gallery, rec \\ false) do
    find_picture_files_in_gallery(gallery)
    |> Enum.filter(fn {path, _, _} -> Galleries.picture_by_path(path) == nil end)
    |> Enum.each(&index_picture!/1)
    if rec do
      Galleries.list_child_galleries(gallery.id)
      |> Enum.each(&index_gallery/1)
    end
  end

  def index_picture!({path, name, gallery_id}) do
    {w, h} = Configuration.get_thumb_size!()
    case Native.scan_picture(path, Configuration.get_thumbs_dir!(), w, h) do
      {:ok, scanned_attrs} -> {:ok, %{size: size}} = File.stat(path)
                              pic_attrs = scanned_attrs
                                          |> Map.from_struct()
                                          |> Map.put(:filesize, size)
                                          |> Map.put(:sha1, hash_file(path))
                                          |> Map.put(:path, path)
                                          |> Map.put(:name, name)
                                          |> Map.put(:rank, 0)
                              {:ok, pic} = Galleries.create_picture(pic_attrs)
                              {:ok, _} = Galleries.create_gallery_picture(
                                %{
                                  gallery_id: gallery_id,
                                  picture_id: pic.id,
                                }
                              )
      {:error, err} -> IO.puts("Error scanning file '#{name}': '#{err}'")
    end
  end

  def create_thumb(%Picture{} = pic, size) do
    thumb_path = Galleries.thumb_path_for_picture!(pic)
    if !File.exists?(thumb_path) do
      schedule_thumbnail_creation(pic, thumb_path, size)
      |> Task.await(1_000_000)
    end
  end

  defp find_picture_files_in_gallery(
         %Gallery{
           :id => gallery_id,
           :directory => dir,
         }
       ) do
    File.ls!(dir)
    |> Enum.filter(&accept_file/1)
    |> Enum.map(fn file -> {dir <> "/" <> file, file, gallery_id} end)
  end

  def accept_file(filename) do
    extension = filename
                |> extension()
    !File.dir?(filename) && String.downcase(extension) in @valid_extensions
  end

  defp schedule_thumbnail_creation(pic, thumb_path, size) do
    Task.async(
      fn ->
        :poolboy.transaction(
          :thumbs_worker,
          fn pid ->
             GenServer.call(pid, {:generate_thumb, pic.path, thumb_path, size}, 1_000_000)
          end,
          1_000_000
        )
      end
    )
  end

end