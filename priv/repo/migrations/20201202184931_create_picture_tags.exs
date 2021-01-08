defmodule Regal.Repo.Migrations.CreatePictureTags do
  use Ecto.Migration

  def change do
    create table(:picture_tags) do
      add :picture_id, references(:pictures, on_delete: :delete_all)
      add :tag_id, references(:tags, on_delete: :delete_all)

      timestamps()
    end

    create index(:picture_tags, [:picture_id])
    create index(:picture_tags, [:tag_id])
    create unique_index(:picture_tags, [:picture_id, :tag_id])
  end
end
