defmodule Regal.Galleries.PictureTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "picture_tags" do
    field :picture_id, :id
    field :tag_id, :id

    timestamps()
  end

  @doc false
  def changeset(picture_tag, attrs) do
    picture_tag
    |> cast(attrs, [])
    |> validate_required([])
  end
end
