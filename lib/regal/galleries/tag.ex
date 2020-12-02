defmodule Regal.Galleries.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :color, :string
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :description, :color])
    |> validate_required([:name, :description, :color])
  end
end
