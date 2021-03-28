alias Regal.Galleries

root = File.cwd!
fixture_dir = root <> "/fixture_data"
galleries_dir = fixture_dir <> "/galleries"

gallery_data = [
    {"Switzerland", "switzerland"},
    {"Norway", "norway"},
]

mountain_pics = [
    "20201025_162211",
    "20201122_133607",
    "20201122_140431",
    "20201122_143350",
    "20201122_152309",
    "20201122_154452",
    "20201122_160621",
    "20190617_153538",
    "20190617_161008",
    "20190619_113933",
    "20190619_113959",
]

defmodule Fixtures do
    def create_gallery_if_not_exists(name, path) do
        case Galleries.gallery_for_path(path) do
            nil -> {:ok, gallery} = Galleries.create_gallery(%{
                name: name,
                directory: path,
            })
                   gallery
            gallery -> gallery
        end
    end

    def create_tag_if_not_exists(color, name, desc) do
        case Galleries.tag_by_name(name) do
            nil -> {:ok, tag} = Galleries.create_tag(%{
                color: color,
                name: name,
                description: desc,
            })
                   tag
            tag -> tag
        end
    end
end

IO.puts("====================")
IO.puts(" Creating galleries")
IO.puts("====================")

galleries = gallery_data
            |> Enum.map(fn {name, dir_name} -> Fixtures.create_gallery_if_not_exists(name, galleries_dir <> "/" <> dir_name) end)

fixture_tag = Fixtures.create_tag_if_not_exists("yellow", "fixture", "Fixture picture for testing purposes")
mountain_tag = Fixtures.create_tag_if_not_exists("blue", "mountain", "Picture of a mountain")

IO.puts("===================")
IO.puts(" Creating pictures")
IO.puts("===================")

Galleries.index_all_galleries()

IO.puts("==================")
IO.puts(" Tagging pictures")
IO.puts("==================")

Enum.each(Galleries.list_pictures(), fn pic ->
    Galleries.create_picture_tag(%{
        tag_id: fixture_tag.id,
        picture_id: pic.id,
    })
end)

mountain_pics
|> Enum.flat_map(fn name ->
    galleries
    |> Enum.map(fn g -> g.directory end)
    |> Enum.map(fn d -> d <> "/IMG_" <> name <> ".jpg" end)
end)
|> Enum.map(&Galleries.picture_by_path/1)
|> Enum.filter(fn pic -> pic != nil end)
|> Enum.each(fn pic ->
    Galleries.create_picture_tag(%{
        tag_id: mountain_tag.id,
        picture_id: pic.id,
    })
end)

IO.puts("=============================")
IO.puts(" Creating missing thumbnails")
IO.puts("=============================")
