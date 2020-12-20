defmodule RegalWeb.TagController do
  use RegalWeb, :controller

  alias Regal.Galleries
  alias Regal.Galleries.Tag

  def index(conn, _params) do
    tags = Galleries.list_tags()
    render(conn, "index.html", tags: tags)
  end

  def new(conn, _params) do
    changeset = Galleries.change_tag(%Tag{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tag" => tag_params}) do
    case Galleries.create_tag(tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag created successfully.")
        |> redirect(to: Routes.tag_path(conn, :show, tag))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Galleries.get_tag!(id)
    n_pics = Galleries.count_tagged_pictures(tag.id)
    render(conn, "show.html", tag: tag, n_pics: n_pics)
  end

  def edit(conn, %{"id" => id}) do
    tag = Galleries.get_tag!(id)
    changeset = Galleries.change_tag(tag)
    render(conn, "edit.html", tag: tag, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Galleries.get_tag!(id)

    case Galleries.update_tag(tag, tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag updated successfully.")
        |> redirect(to: Routes.tag_path(conn, :show, tag))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tag: tag, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Galleries.get_tag!(id)
    {:ok, _tag} = Galleries.delete_tag(tag)

    conn
    |> put_flash(:info, "Tag deleted successfully.")
    |> redirect(to: Routes.tag_path(conn, :index))
  end
end
