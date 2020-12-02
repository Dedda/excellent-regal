defmodule Regal.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
      add :description, :string
      add :color, :string

      timestamps()
    end

  end
end
