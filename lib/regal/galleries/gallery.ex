defmodule Regal.Galleries.Gallery do
  use Ecto.Schema
  import Ecto.Changeset

  schema "galleries" do
    field :directory, :string
    field :name, :string
    field :parent_id, :id

    timestamps()
  end

  @doc false
  def changeset(gallery, attrs) do
    gallery
    |> cast(attrs, [:name, :directory, :parent_id])
    |> validate_required([:name, :directory])
  end
end
