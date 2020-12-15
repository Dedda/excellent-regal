defmodule Regal.Configuration.ConfigValue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "config_values" do
    field :name, :string
    field :value, :string
    field :parent, :id

    timestamps()
  end

  @doc false
  def changeset(config_value, attrs) do
    config_value
    |> cast(attrs, [:name, :value])
    |> validate_required([:name, :value])
  end
end
