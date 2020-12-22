defmodule RegalWeb.PictureController do
  use RegalWeb, :controller

  alias Regal.Galleries
  alias Regal.Galleries.Picture

  def index(conn, _params) do
    pictures = Galleries.list_pictures()
    render(conn, "index.html", pictures: pictures)
  end

  def new(conn, _params) do
    changeset = Galleries.change_picture(%Picture{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"picture" => picture_params}) do
    case Galleries.create_picture(picture_params) do
      {:ok, picture} ->
        conn
        |> put_flash(:info, "Picture created successfully.")
        |> redirect(to: Routes.picture_path(conn, :show, picture))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    picture = Galleries.get_picture!(id)
    filesize = Sizeable.filesize(picture.filesize)
    download_name = picture.external_id <> "/" <> picture.format
    render(conn, "show.html", picture: picture, filesize: filesize, download_name: download_name)
  end

  def edit(conn, %{"id" => id}) do
    picture = Galleries.get_picture!(id)
    changeset = Galleries.change_picture(picture)
    render(conn, "edit.html", picture: picture, changeset: changeset)
  end

  def update(conn, %{"id" => id, "picture" => picture_params}) do
    picture = Galleries.get_picture!(id)

    case Galleries.update_picture(picture, picture_params) do
      {:ok, picture} ->
        conn
        |> put_flash(:info, "Picture updated successfully.")
        |> redirect(to: Routes.picture_path(conn, :show, picture))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", picture: picture, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    picture = Galleries.get_picture!(id)
    {:ok, _picture} = Galleries.delete_picture(picture)

    conn
    |> put_flash(:info, "Picture deleted successfully.")
    |> redirect(to: Routes.picture_path(conn, :index))
  end

  def raw(conn, %{"id" => external_id}) do
    picture = Galleries.get_picture_by_external_id!(external_id)
    data = File.read!(picture.path)
    conn
    |> put_resp_content_type("image/" <> picture.format)
    |> send_resp(:ok, data)
  end

  def thumb(conn, %{"id" => external_id}) do
    pic = Galleries.get_picture_by_external_id!(external_id)
    path = Galleries.thumb_path_for_picture!(pic)
    if !File.exists?(path) do
      Regal.Scanner.create_thumb(pic)
    end
    data = File.read!(path)
    conn
    |> put_resp_content_type("image/png")
    |> send_resp(:ok, data)
  end
end
