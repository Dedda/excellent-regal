# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Regal.Repo.insert!(%Regal.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Regal.Configuration

Configuration.create_config_value(%{
  name: "thumbs_dir",
  value: "?mixdir?/fixture_data/thumbs",
})

Configuration.create_config_value(%{
  name: "thumb_size_w",
  value: "500",
})

Configuration.create_config_value(%{
  name: "thumb_size_h",
  value: "500",
})