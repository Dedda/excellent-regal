defmodule RegalWeb.PictureView do
  use RegalWeb, :view

  def gallery_thumbnail(conn, picture) do
    render("gallery_thumbnail.html", %{conn: conn, picture: picture})
  end
end
