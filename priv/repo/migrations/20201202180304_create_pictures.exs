defmodule Regal.Repo.Migrations.CreatePictures do
  use Ecto.Migration

  def change do
    create table(:pictures) do
      add :name, :string
      add :width, :integer
      add :height, :integer
      add :format, :string
      add :path, :string
      add :sha1, :string
      add :filesize, :integer
      add :external_id, :string
      add :rank, :integer
      add :gallery_id, references(:galleries, on_delete: :nothing)

      timestamps()
    end

    create index(:pictures, [:gallery_id])
  end
end
