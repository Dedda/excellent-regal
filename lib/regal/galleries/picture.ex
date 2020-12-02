defmodule Regal.Galleries.Picture do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pictures" do
    field :external_id, Ecto.UUID
    field :filesize, :integer
    field :format, :string
    field :height, :integer
    field :name, :string
    field :path, :string
    field :rank, :integer
    field :sha1, :string
    field :width, :integer
    field :gallery_id, :id

    timestamps()
  end

  @doc false
  def changeset(picture, attrs) do
    picture
    |> cast(attrs, [:name, :width, :height, :format, :path, :sha1, :filesize, :external_id, :rank])
    |> validate_required([:name, :width, :height, :format, :path, :sha1, :filesize, :external_id, :rank])
  end
end
