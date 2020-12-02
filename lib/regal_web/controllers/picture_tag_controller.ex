defmodule RegalWeb.PictureTagController do
  use RegalWeb, :controller

  alias Regal.Galleries
  alias Regal.Galleries.PictureTag

  def index(conn, _params) do
    picture_tags = Galleries.list_picture_tags()
    render(conn, "index.html", picture_tags: picture_tags)
  end

  def new(conn, _params) do
    changeset = Galleries.change_picture_tag(%PictureTag{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"picture_tag" => picture_tag_params}) do
    case Galleries.create_picture_tag(picture_tag_params) do
      {:ok, picture_tag} ->
        conn
        |> put_flash(:info, "Picture tag created successfully.")
        |> redirect(to: Routes.picture_tag_path(conn, :show, picture_tag))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    picture_tag = Galleries.get_picture_tag!(id)
    render(conn, "show.html", picture_tag: picture_tag)
  end

  def edit(conn, %{"id" => id}) do
    picture_tag = Galleries.get_picture_tag!(id)
    changeset = Galleries.change_picture_tag(picture_tag)
    render(conn, "edit.html", picture_tag: picture_tag, changeset: changeset)
  end

  def update(conn, %{"id" => id, "picture_tag" => picture_tag_params}) do
    picture_tag = Galleries.get_picture_tag!(id)

    case Galleries.update_picture_tag(picture_tag, picture_tag_params) do
      {:ok, picture_tag} ->
        conn
        |> put_flash(:info, "Picture tag updated successfully.")
        |> redirect(to: Routes.picture_tag_path(conn, :show, picture_tag))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", picture_tag: picture_tag, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    picture_tag = Galleries.get_picture_tag!(id)
    {:ok, _picture_tag} = Galleries.delete_picture_tag(picture_tag)

    conn
    |> put_flash(:info, "Picture tag deleted successfully.")
    |> redirect(to: Routes.picture_tag_path(conn, :index))
  end
end
