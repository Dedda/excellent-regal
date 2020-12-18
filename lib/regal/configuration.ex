defmodule Regal.Configuration do
  @moduledoc """
  The Configuration context.
  """

  import Ecto.Query, warn: false
  alias Regal.Repo

  alias Regal.Configuration.ConfigValue

  @project_root File.cwd!

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



  def project_root do
    @project_root
  end

  def get_thumbs_dir! do
    %ConfigValue{
      value: path
    } = Repo.one!(from c in ConfigValue,
                  where: c.name == ^"thumbs_dir")
    String.replace(path, "?mixdir?", @project_root)
  end

  def get_thumb_size! do
    %ConfigValue{
      value: width
    } = Repo.one!(from c in ConfigValue,
                  where: c.name == ^"thumb_size_w")
    %ConfigValue{
      value: height
    } = Repo.one!(from c in ConfigValue,
                  where: c.name == ^"thumb_size_h")
    {w, _} = Integer.parse(width)
    {h, _} = Integer.parse(height)
    {w, h}
  end
end
