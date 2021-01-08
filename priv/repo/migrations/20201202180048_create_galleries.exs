defmodule Regal.Repo.Migrations.CreateGalleries do
  use Ecto.Migration

  def change do
    create table(:galleries) do
      add :name, :string
      add :directory, :string
      add :recursive, :boolean, default: false
      add :parent_id, references(:galleries, on_delete: :nothing)

      timestamps()
    end

    create index(:galleries, [:parent_id])
    create unique_index(:galleries, [:directory])
  end
end
