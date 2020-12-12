defmodule RegalWeb.GalleryPictureController do
  use RegalWeb, :controller

  alias Regal.Galleries
  alias Regal.Galleries.GalleryPicture

  def index(conn, _params) do
    gallery_pictures = Galleries.list_gallery_pictures()
    render(conn, "index.html", gallery_pictures: gallery_pictures)
  end

  def new(conn, _params) do
    changeset = Galleries.change_gallery_picture(%GalleryPicture{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gallery_picture" => gallery_picture_params}) do
    case Galleries.create_gallery_picture(gallery_picture_params) do
      {:ok, gallery_picture} ->
        conn
        |> put_flash(:info, "Gallery picture created successfully.")
        |> redirect(to: Routes.gallery_picture_path(conn, :show, gallery_picture))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    gallery_picture = Galleries.get_gallery_picture!(id)
    render(conn, "show.html", gallery_picture: gallery_picture)
  end

  def edit(conn, %{"id" => id}) do
    gallery_picture = Galleries.get_gallery_picture!(id)
    changeset = Galleries.change_gallery_picture(gallery_picture)
    render(conn, "edit.html", gallery_picture: gallery_picture, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gallery_picture" => gallery_picture_params}) do
    gallery_picture = Galleries.get_gallery_picture!(id)

    case Galleries.update_gallery_picture(gallery_picture, gallery_picture_params) do
      {:ok, gallery_picture} ->
        conn
        |> put_flash(:info, "Gallery picture updated successfully.")
        |> redirect(to: Routes.gallery_picture_path(conn, :show, gallery_picture))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", gallery_picture: gallery_picture, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gallery_picture = Galleries.get_gallery_picture!(id)
    {:ok, _gallery_picture} = Galleries.delete_gallery_picture(gallery_picture)

    conn
    |> put_flash(:info, "Gallery picture deleted successfully.")
    |> redirect(to: Routes.gallery_picture_path(conn, :index))
  end
end
