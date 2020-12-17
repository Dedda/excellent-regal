alias Regal.Galleries

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

Enum.map(1..5 , fn i ->
    cake_name = "cake-0#{i}"
    mountain_name = "mountain-0#{i}"
    {:ok, cake_pic} = Galleries.create_picture(%{
        external_id: UUID.uuid4(),
        format: "jpg",
        name: cake_name,
        path: cakes.directory <> "/" <> cake_name <> ".jpg",
        sha1: "-",
        rank: i,
        filesize: 0,
        width: 0,
        height: 0,
    })
    {:ok, mountain_pic} = Galleries.create_picture(%{
        external_id: UUID.uuid4(),
        format: "jpg",
        name: mountain_name,
        path: mountains.directory <> "/" <> mountain_name <> ".jpg",
        sha1: "-",
        rank: i,
        filesize: 0,
        width: 0,
        height: 0,
    })
    {:ok, _} = Galleries.create_gallery_picture(%{
        gallery_id: cakes.id,
        picture_id: cake_pic.id,
    })
    {:ok, _} = Galleries.create_gallery_picture(%{
        gallery_id: mountains.id,
        picture_id: mountain_pic.id,
    })
    {:ok, _} = Galleries.create_picture_tag(%{
        tag_id: cake_tag.id,
        picture_id: cake_pic.id,
    })
    {:ok, _} = Galleries.create_picture_tag(%{
        tag_id: mountain_tag.id,
        picture_id: mountain_pic.id,
    })
end)

Enum.map(Galleries.list_pictures(), fn pic ->
    {:ok, _} = Galleries.create_picture_tag(%{
        tag_id: fixture_tag.id,
        picture_id: pic.id,
    })
end)