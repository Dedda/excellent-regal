defmodule RegalWeb.PageController do
  use RegalWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def credits(conn, _params) do
    render(conn, "credits.html")
  end

  def create_index(conn, _params) do
    spawn fn -> Regal.Galleries.index_all_galleries() end
    conn
    |> put_flash(:info, "All galleries will be indexed.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
