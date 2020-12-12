defmodule Regal.Galleries.GalleryPicture do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gallery_pictures" do
    field :gallery_id, :id
    field :picture_id, :id

    timestamps()
  end

  @doc false
  def changeset(gallery_picture, attrs) do
    gallery_picture
    |> cast(attrs, [])
    |> validate_required([])
  end
end
