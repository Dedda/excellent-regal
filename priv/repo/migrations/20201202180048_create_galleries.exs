defmodule Regal.Repo.Migrations.CreateGalleries do
  use Ecto.Migration

  def change do
    create table(:galleries) do
      add :name, :string
      add :directory, :string
      add :parent_id, references(:galleries, on_delete: :nothing)

      timestamps()
    end

    create index(:galleries, [:parent_id])
  end
end
