defmodule Regal.Galleries do

  import Ecto.Query, warn: false
  alias Regal.Repo
  alias Regal.Scanner

  alias Regal.Galleries.Gallery

  def list_galleries do
    Repo.all(Gallery)
  end

  def list_top_galleries do
    Repo.all(from g in Gallery, where: is_nil(g.parent_id))
  end

  def list_child_galleries(parent_id) do
    Repo.all(from g in Gallery, where: g.parent_id == ^parent_id)
  end

  def get_gallery!(id), do: Repo.get!(Gallery, id)

  def create_gallery(attrs \\ %{}, sync \\ false) do
    gallery = %Gallery{}
              |> Gallery.changeset(attrs)
              |> Repo.insert()
    case gallery do
      {:ok, g} -> if g.directory != nil && g.recursive do
                    create_sub_galleries(g, sync)
                  end
                  {:ok, g}
      err -> err
    end
  end

  def create_sub_galleries(parent = %Gallery{}, sync \\ false) do
    {:ok, files} = File.ls(parent.directory)
    files
    |> Enum.filter(fn name -> File.dir?(parent.directory <> "/" <> name) end)
    |> Enum.map(fn name ->
      %{
        name: name,
        directory: parent.directory <> "/" <> name,
        recursive: true,
        parent_id: parent.id,
      }
    end)
    |> Enum.map(&create_gallery/1)
    |> Enum.filter(fn g -> elem(g, 0) == :ok end)
    |> Enum.map(fn g -> elem(g, 1) end)
    |> Enum.each(fn gallery ->
      if sync do
        Scanner.index_gallery(gallery)
      else
        spawn(fn -> Scanner.index_gallery(gallery) end)
      end
    end)
  end

  def gallery_for_path(nil) do
    nil
  end

  def gallery_for_path(path) do
    Repo.one(from g in Gallery, where: g.directory == ^path)
  end

  def update_gallery(%Gallery{} = gallery, attrs) do
    gallery
    |> Gallery.changeset(attrs)
    |> Repo.update()
  end

  def delete_gallery(%Gallery{} = gallery) do
    Repo.delete(gallery)
  end

  def change_gallery(%Gallery{} = gallery, attrs \\ %{}) do
    Gallery.changeset(gallery, attrs)
  end

  def index_all_galleries do
    Repo.all(Gallery)
    |> Enum.filter(fn gallery ->
      dir = gallery.directory
      dir != nil && File.exists?(dir)
    end)
    |> Enum.flat_map(&create_thumbs_in_gallery/1)
    |> Enum.map(Regal.TaskHelper.await_with_timeout(1_000_000))
  end

  alias Regal.Galleries.Picture

  def list_pictures do
    Repo.all(Picture)
  end

  def get_picture!(id), do: Repo.get!(Picture, id)

  def create_picture(attrs \\ %{}) do
    %Picture{}
    |> Picture.changeset(attrs)
    |> Repo.insert()
  end

  def update_picture(%Picture{} = picture, attrs) do
    picture
    |> Picture.changeset(attrs)
    |> Repo.update()
  end

  def delete_picture(%Picture{} = picture) do
    Repo.delete(picture)
  end

  def change_picture(%Picture{} = picture, attrs \\ %{}) do
    Picture.changeset(picture, attrs)
  end

  alias Regal.Galleries.Tag

  def list_tags do
    Repo.all(Tag)
  end

  def get_tag!(id), do: Repo.get!(Tag, id)

  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  def tag_by_name(name) do
    Repo.one(from t in Tag, where: t.name == ^name)
  end

  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  alias Regal.Galleries.PictureTag

  def list_picture_tags do
    Repo.all(PictureTag)
  end

  def get_picture_tag!(id), do: Repo.get!(PictureTag, id)

  def tags_by_picture(pic_id) do
    query = from t in Tag,
                 join: pt in PictureTag, on: t.id == pt.tag_id,
                 where: pt.picture_id == ^pic_id,
                 select: t
    Repo.all(query)
  end


  def create_picture_tag(attrs \\ %{}) do
    %PictureTag{}
    |> PictureTag.changeset(attrs)
    |> Repo.insert()
  end

  def update_picture_tag(%PictureTag{} = picture_tag, attrs) do
    picture_tag
    |> PictureTag.changeset(attrs)
    |> Repo.update()
  end

  def delete_picture_tag(%PictureTag{} = picture_tag) do
    Repo.delete(picture_tag)
  end

  def change_picture_tag(%PictureTag{} = picture_tag, attrs \\ %{}) do
    PictureTag.changeset(picture_tag, attrs)
  end

  def pictures_by_tag(tag_id) do
    query = from p in Picture,
            join: pt in PictureTag, on: p.id == pt.picture_id,
            where: pt.tag_id == ^tag_id,
            select: p
    Repo.all(query)
  end

  def count_tagged_pictures(tag_id) do
    query = from pt in PictureTag,
            where: pt.tag_id == ^tag_id
    count(query, :tag_id)
  end

  alias Regal.Galleries.GalleryPicture

  def list_gallery_pictures do
    Repo.all(GalleryPicture)
  end

  def get_gallery_picture!(id), do: Repo.get!(GalleryPicture, id)

  def create_gallery_picture(attrs \\ %{}) do
    %GalleryPicture{}
    |> GalleryPicture.changeset(attrs)
    |> Repo.insert()
  end

  def update_gallery_picture(%GalleryPicture{} = gallery_picture, attrs) do
    gallery_picture
    |> GalleryPicture.changeset(attrs)
    |> Repo.update()
  end

  def delete_gallery_picture(%GalleryPicture{} = gallery_picture) do
    Repo.delete(gallery_picture)
  end

  def change_gallery_picture(%GalleryPicture{} = gallery_picture, attrs \\ %{}) do
    GalleryPicture.changeset(gallery_picture, attrs)
  end

  def pictures_for_gallery!(gallery_id) do
    gal_pic_query = from gp in GalleryPicture,
                    where: gp.gallery_id == ^gallery_id
    gallery_pictures = Repo.all(gal_pic_query)
      |> Enum.map(fn gp -> gp.picture_id end)
    Repo.all(from p in Picture, where: p.id in ^gallery_pictures, order_by: p.rank)
  end

  def get_gallery_thumb(gallery_id) do
    query = from p in Picture,
            join: gp in GalleryPicture, on: gp.picture_id == p.id,
            where: gp.gallery_id == ^gallery_id,
            select: p,
            order_by: p.inserted_at,
            limit: 1
    Repo.one(query)
  end

  def picture_by_path(path) do
    query = from p in Picture,
            where: p.path == ^path
    Repo.one(query)
  end

  def get_picture_by_external_id!(external_id) do
    pic_query = from p in Picture,
                where: p.external_id == ^external_id
    Repo.one!(pic_query)
  end

  def get_picture_by_external_id(external_id) do
    pic_query = from p in Picture,
                     where: p.external_id == ^external_id
    Repo.one(pic_query)
  end

  def thumb_path_for_picture!(pic) do
    Regal.Configuration.get_thumbs_dir!() <> "/" <> pic.external_id <> ".png"
  end

  defp count(query, field) do
    Repo.aggregate(query, :count, field)
  end

  defp create_thumbs_in_gallery(gallery) do
    thumb_size = Regal.Configuration.get_thumb_size!()
    Scanner.index_gallery(gallery)
    pictures_for_gallery!(gallery.id)
    |> Enum.filter(fn picture ->
      !File.exists?(thumb_path_for_picture!(picture))
    end)
    |> Enum.map(fn picture ->
      Task.async fn ->
          Scanner.create_thumb(picture, thumb_size)
      end
    end)
  end
end
