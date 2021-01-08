defmodule Regal.Galleries.Gallery do
  use Ecto.Schema
  import Ecto.Changeset

  schema "galleries" do
    field :directory, :string
    field :name, :string
    field :recursive, :boolean
    field :parent_id, :id

    timestamps()
  end

  @doc false
  def changeset(gallery, attrs) do
    gallery
    |> cast(attrs, [:name, :directory, :recursive, :parent_id])
    |> unique_constraint([:directory])
    |> validate_required([:name])
  end
end
