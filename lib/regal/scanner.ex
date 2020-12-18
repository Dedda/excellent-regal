defmodule Regal.Scanner do

  alias Regal.Configuration
  alias Regal.Native
  alias Regal.Galleries
  alias Regal.Galleries.Gallery

  @valid_extensions ["png", "jpg", "jpeg"]

  def index_gallery(%Gallery{} = gallery, rec \\ false) do
    find_picture_files_in_gallery(gallery)
    |> Enum.filter(fn {path, _, _} -> Galleries.picture_by_path(path) == nil end)
    |> Enum.each(&index_picture!/1)
    if rec do
      Galleries.get_sub_galleries(gallery.id)
      |> Enum.each(&index_gallery/1)
    end
  end

  def index_picture!({path, name, gallery_id}) do
    {w, h} = Configuration.get_thumb_size!()
    {:ok, scanned_attrs} = Native.scan_picture(path, Configuration.get_thumbs_dir!(), w, h)
    {:ok, %{size: size}} = File.stat(path)
    pic_attrs = scanned_attrs
                |> Map.from_struct()
                |> Map.put(:filesize, size)
                |> Map.put(:sha1, hash_file(path))
                |> Map.put(:path, path)
                |> Map.put(:name, name)
                |> Map.put(:rank, 0)
    {:ok, pic} = Galleries.create_picture(pic_attrs)
    {:ok, _} = Galleries.create_gallery_picture(%{
      gallery_id: gallery_id,
      picture_id: pic.id,
    })
  end

  def find_picture_files_in_gallery(%Gallery{
    :id => gallery_id,
    :directory => dir,
  }) do
    File.ls!(dir)
    |> Enum.filter(&accept_file/1)
    |> Enum.map(fn file -> { dir <> "/" <> file, file, gallery_id } end)
  end
  
  def accept_file(filename) do
    extension = filename
                |> extension()
    !File.dir?(filename) && extension in @valid_extensions
  end

  defp extension(filename) do
    filename
    |> String.split(".")
    |> List.last()
  end

  def hash_file(path) do
    :crypto.hash(:sha, File.read!(path))
    |> Base.encode16()
    |> String.downcase()
  end

end