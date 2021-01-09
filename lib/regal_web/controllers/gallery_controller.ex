defmodule RegalWeb.GalleryController do
  use RegalWeb, :controller

  alias Regal.Galleries
  alias Regal.Galleries.Gallery

  def index(conn, _params) do
    galleries = Galleries.list_top_galleries()
    render(conn, "index.html", galleries: galleries)
  end

  def new(conn, _params) do
    changeset = Galleries.change_gallery(%Gallery{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gallery" => gallery_params}) do
    clean_dir = case gallery_params["directory"] do
      nil -> nil
      "" -> nil
      dir -> String.replace(dir, "\\", "/")
    end
    params = Map.put(gallery_params, "directory", clean_dir)
    case Galleries.create_gallery(params) do
      {:ok, gallery} ->
        if clean_dir != nil && File.exists?(clean_dir) do
          spawn fn ->
            Regal.Scanner.index_gallery(gallery)
          end
        end
        conn
        |> put_flash(:info, "Gallery created successfully.")
        |> redirect(to: Routes.gallery_path(conn, :show, gallery))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    gallery = Galleries.get_gallery!(id)
    pictures = Galleries.pictures_for_gallery!(id)
    sub_galleries = Galleries.list_child_galleries(id)
    render(conn, "show.html", gallery: gallery, children: sub_galleries, pictures: pictures)
  end

  def edit(conn, %{"id" => id}) do
    gallery = Galleries.get_gallery!(id)
    changeset = Galleries.change_gallery(gallery)
    render(conn, "edit.html", gallery: gallery, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gallery" => gallery_params}) do
    gallery = Galleries.get_gallery!(id)

    case Galleries.update_gallery(gallery, gallery_params) do
      {:ok, gallery} ->
        conn
        |> put_flash(:info, "Gallery updated successfully.")
        |> redirect(to: Routes.gallery_path(conn, :show, gallery))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", gallery: gallery, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gallery = Galleries.get_gallery!(id)
    {:ok, _gallery} = Galleries.delete_gallery(gallery)

    conn
    |> put_flash(:info, "Gallery deleted successfully.")
    |> redirect(to: Routes.gallery_path(conn, :index))
  end
end
