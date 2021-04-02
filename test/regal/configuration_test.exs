defmodule Regal.ConfigurationTest do
  use Regal.DataCase

  alias Regal.Configuration

  describe "config_values" do
    alias Regal.Configuration.ConfigValue

    @valid_attrs %{name: "some name", value: "some value"}
    @update_attrs %{name: "some updated name", value: "some updated value"}
    @invalid_attrs %{name: nil, value: nil}

    def config_value_fixture(attrs \\ %{}) do
      {:ok, config_value} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Configuration.create_config_value()

      config_value
    end

    test "necessary config values exist" do
      found = Configuration.list_config_values()
              |> Enum.map(fn val -> val.name end)
      missing = ["thumbs_dir", "thumb_size_w", "thumb_size_h"]
                |> Enum.reject(fn name -> Enum.member?(found, name) end)
      assert [] == missing
    end

    test "get_config_value!/1 returns the config_value with given id" do
      config_value = config_value_fixture()
      assert Configuration.get_config_value!(config_value.id) == config_value
    end

    test "create_config_value/1 with valid data creates a config_value" do
      assert {:ok, %ConfigValue{} = config_value} = Configuration.create_config_value(@valid_attrs)
      assert config_value.name == "some name"
      assert config_value.value == "some value"
    end

    test "create_config_value/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Configuration.create_config_value(@invalid_attrs)
    end

    test "update_config_value/2 with valid data updates the config_value" do
      config_value = config_value_fixture()
      assert {:ok, %ConfigValue{} = config_value} = Configuration.update_config_value(config_value, @update_attrs)
      assert config_value.name == "some updated name"
      assert config_value.value == "some updated value"
    end

    test "update_config_value/2 with invalid data returns error changeset" do
      config_value = config_value_fixture()
      assert {:error, %Ecto.Changeset{}} = Configuration.update_config_value(config_value, @invalid_attrs)
      assert config_value == Configuration.get_config_value!(config_value.id)
    end

    test "delete_config_value/1 deletes the config_value" do
      config_value = config_value_fixture()
      assert {:ok, %ConfigValue{}} = Configuration.delete_config_value(config_value)
      assert_raise Ecto.NoResultsError, fn -> Configuration.get_config_value!(config_value.id) end
    end

    test "change_config_value/1 returns a config_value changeset" do
      config_value = config_value_fixture()
      assert %Ecto.Changeset{} = Configuration.change_config_value(config_value)
    end
  end
end
