defmodule RegalWeb.GalleryView do
  use RegalWeb, :view

  def gallery_thumbnail(conn, gallery) do
    case Regal.Galleries.get_gallery_thumb(gallery.id) do
      nil ->
        render("gallery_thumbnail_placeholder.html", %{conn: conn, gallery: gallery})
      picture -> render("gallery_thumbnail.html", %{conn: conn, gallery: gallery, picture: picture})
    end
  end
end
