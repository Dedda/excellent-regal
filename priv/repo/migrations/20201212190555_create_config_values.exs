defmodule Regal.Repo.Migrations.CreateConfigValues do
  use Ecto.Migration

  def change do
    create table(:config_values) do
      add :name, :string
      add :value, :string
      add :parent, references(:config_values, on_delete: :nothing)

      timestamps()
    end

    create index(:config_values, [:parent])
  end
end
