alias Regal.Galleries
alias Regal.Repo
alias Regal.Scanner

root = File.cwd!
fixture_dir = root <> "/fixture_data"
galleries_dir = fixture_dir <> "/galleries"

{:ok, cakes} = Galleries.create_gallery(%{
    name: "Cakes",
    directory: galleries_dir <> "/cakes",
})

{:ok, mountains} = Galleries.create_gallery(%{
    name: "Mountains",
    directory: galleries_dir <> "/mountains",
})

{:ok, fixture_tag} = Galleries.create_tag(%{
    color: "yellow",
    name: "fixture",
    description: "Fixture picture for testing purposes",
})

{:ok, cake_tag} = Galleries.create_tag(%{
    color: "red",
    name: "cake",
    description: "Picture of a cake",
})

{:ok, mountain_tag} = Galleries.create_tag(%{
    color: "blue",
    name: "mountain",
    description: "Picture of a mountain",
})

Scanner.index_gallery(cakes)
Scanner.index_gallery(mountains)

Galleries.pictures_for_gallery!(cakes.id)
|> Enum.each(fn pic ->
    {:ok, _} = Galleries.create_picture_tag(%{
        picture_id: pic.id,
        tag_id: cake_tag.id,
    })
end)

Galleries.pictures_for_gallery!(mountains.id)
|> Enum.each(fn pic ->
    {:ok, _} = Galleries.create_picture_tag(%{
        picture_id: pic.id,
        tag_id: mountain_tag.id,
    })
end)

Enum.map(Galleries.list_pictures(), fn pic ->
    {:ok, _} = Galleries.create_picture_tag(%{
        tag_id: fixture_tag.id,
        picture_id: pic.id,
    })
end)