alias Regal.Configuration
alias Regal.Galleries
alias Regal.Scanner

root = File.cwd!
fixture_dir = root <> "/fixture_data"
galleries_dir = fixture_dir <> "/galleries"

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

cakes = Fixtures.create_gallery_if_not_exists("Cakes", galleries_dir <> "/cakes")
mountains = Fixtures.create_gallery_if_not_exists("Mountains", galleries_dir <> "/mountains")

fixture_tag = Fixtures.create_tag_if_not_exists("yellow", "fixture", "Fixture picture for testing purposes")
cake_tag = Fixtures.create_tag_if_not_exists("red", "cake", "Picture of a cake")
mountain_tag = Fixtures.create_tag_if_not_exists("blue", "mountain", "Picture of a mountain")

IO.puts("===================")
IO.puts(" Creating pictures")
IO.puts("===================")

Scanner.index_gallery(cakes)
Scanner.index_gallery(mountains)

IO.puts("==================")
IO.puts(" Tagging pictures")
IO.puts("==================")

Galleries.pictures_for_gallery!(cakes.id)
|> Enum.each(fn pic ->
    Galleries.create_picture_tag(%{
        picture_id: pic.id,
        tag_id: cake_tag.id,
    })
end)

Galleries.pictures_for_gallery!(mountains.id)
|> Enum.each(fn pic ->
    Galleries.create_picture_tag(%{
        picture_id: pic.id,
        tag_id: mountain_tag.id,
    })
end)

Enum.each(Galleries.list_pictures(), fn pic ->
    Galleries.create_picture_tag(%{
        tag_id: fixture_tag.id,
        picture_id: pic.id,
    })
end)

IO.puts("=============================")
IO.puts(" Creating missing thumbnails")
IO.puts("=============================")

Enum.each(Galleries.list_pictures(), fn pic ->
    Scanner.create_thumb(pic)
end)

