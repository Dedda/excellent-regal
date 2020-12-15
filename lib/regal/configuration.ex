defmodule Regal.Configuration do
  @moduledoc """
  The Configuration context.
  """

  import Ecto.Query, warn: false
  alias Regal.Repo

  alias Regal.Configuration.ConfigValue

  def list_config_values do
    Repo.all(ConfigValue)
  end

  def get_config_value!(id), do: Repo.get!(ConfigValue, id)

  def create_config_value(attrs \\ %{}) do
    %ConfigValue{}
    |> ConfigValue.changeset(attrs)
    |> Repo.insert()
  end

  def update_config_value(%ConfigValue{} = config_value, attrs) do
    config_value
    |> ConfigValue.changeset(attrs)
    |> Repo.update()
  end

  def delete_config_value(%ConfigValue{} = config_value) do
    Repo.delete(config_value)
  end

  def change_config_value(%ConfigValue{} = config_value, attrs \\ %{}) do
    ConfigValue.changeset(config_value, attrs)
  end
end
