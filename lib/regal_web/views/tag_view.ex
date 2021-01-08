defmodule RegalWeb.TagView do
  use RegalWeb, :view

  def inline_tag(conn, color) do
    render("inline_tag.html", %{conn: conn, color: color})
  end
end
