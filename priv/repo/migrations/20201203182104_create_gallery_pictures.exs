defmodule Regal.Repo.Migrations.CreateGalleryPictures do
  use Ecto.Migration

  def change do
    create table(:gallery_pictures) do
      add :gallery_id, references(:galleries, on_delete: :delete_all)
      add :picture_id, references(:pictures, on_delete: :delete_all)

      timestamps()
    end

    create index(:gallery_pictures, [:gallery_id])
    create index(:gallery_pictures, [:picture_id])
  end
end
