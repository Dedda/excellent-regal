defmodule Regal.Repo.Migrations.CreatePictureTags do
  use Ecto.Migration

  def change do
    create table(:picture_tags) do
      add :picture_id, references(:pictures, on_delete: :nothing)
      add :tag_id, references(:tags, on_delete: :nothing)

      timestamps()
    end

    create index(:picture_tags, [:picture_id])
    create index(:picture_tags, [:tag_id])
  end
end
