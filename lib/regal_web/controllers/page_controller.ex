defmodule RegalWeb.PageController do
  use RegalWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def credits(conn, _params) do
    render(conn, "credits.html")
  end
end
