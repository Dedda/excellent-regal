defmodule RegalWeb.ConfigController do
  use RegalWeb, :controller

  alias Regal.Galleries
  alias Regal.Galleries.Tag

  def index(conn, _params) do
    tags = Galleries.list_tags()
    render(conn, "index.html", tags: tags)
  end
end
