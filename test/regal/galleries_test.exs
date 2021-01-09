defmodule Regal.GalleriesTest do
  use Regal.DataCase

  alias Regal.Galleries

  describe "galleries" do
    alias Regal.Galleries.Gallery

    @valid_attrs %{directory: "some directory", name: "some name", recursive: false}
    @update_attrs %{directory: "some updated directory", name: "some updated name", recursive: false}
    @invalid_attrs %{directory: nil, name: nil, recursive: false}

    def gallery_fixture(attrs \\ %{}) do
      {:ok, gallery} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Galleries.create_gallery()

      gallery
    end

    test "list_galleries/0 returns all galleries" do
      gallery = gallery_fixture()
      assert Galleries.list_galleries() == [gallery]
    end

    test "get_gallery!/1 returns the gallery with given id" do
      gallery = gallery_fixture()
      assert Galleries.get_gallery!(gallery.id) == gallery
    end

    test "create_gallery/1 with valid data creates a gallery" do
      assert {:ok, %Gallery{} = gallery} = Galleries.create_gallery(@valid_attrs)
      assert gallery.directory == "some directory"
      assert gallery.name == "some name"
    end

    test "create_gallery/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Galleries.create_gallery(@invalid_attrs)
    end

    test "update_gallery/2 with valid data updates the gallery" do
      gallery = gallery_fixture()
      assert {:ok, %Gallery{} = gallery} = Galleries.update_gallery(gallery, @update_attrs)
      assert gallery.directory == "some updated directory"
      assert gallery.name == "some updated name"
    end

    test "update_gallery/2 with invalid data returns error changeset" do
      gallery = gallery_fixture()
      assert {:error, %Ecto.Changeset{}} = Galleries.update_gallery(gallery, @invalid_attrs)
      assert gallery == Galleries.get_gallery!(gallery.id)
    end

    test "delete_gallery/1 deletes the gallery" do
      gallery = gallery_fixture()
      assert {:ok, %Gallery{}} = Galleries.delete_gallery(gallery)
      assert_raise Ecto.NoResultsError, fn -> Galleries.get_gallery!(gallery.id) end
    end

    test "change_gallery/1 returns a gallery changeset" do
      gallery = gallery_fixture()
      assert %Ecto.Changeset{} = Galleries.change_gallery(gallery)
    end
  end

  describe "pictures" do
    alias Regal.Galleries.Picture

    @valid_attrs %{external_id: "7488a646-e31f-11e4-aace-600308960662", filesize: 42, format: "some format", height: 42, name: "some name", path: "some path", rank: 42, sha1: "some sha1", width: 42}
    @update_attrs %{external_id: "7488a646-e31f-11e4-aace-600308960668", filesize: 43, format: "some updated format", height: 43, name: "some updated name", path: "some updated path", rank: 43, sha1: "some updated sha1", width: 43}
    @invalid_attrs %{external_id: nil, filesize: nil, format: nil, height: nil, name: nil, path: nil, rank: nil, sha1: nil, width: nil}

    def picture_fixture(attrs \\ %{}) do
      {:ok, picture} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Galleries.create_picture()

      picture
    end

    test "list_pictures/0 returns all pictures" do
      picture = picture_fixture()
      assert Galleries.list_pictures() == [picture]
    end

    test "get_picture!/1 returns the picture with given id" do
      picture = picture_fixture()
      assert Galleries.get_picture!(picture.id) == picture
    end

    test "create_picture/1 with valid data creates a picture" do
      assert {:ok, %Picture{} = picture} = Galleries.create_picture(@valid_attrs)
      assert picture.external_id == "7488a646-e31f-11e4-aace-600308960662"
      assert picture.filesize == 42
      assert picture.format == "some format"
      assert picture.height == 42
      assert picture.name == "some name"
      assert picture.path == "some path"
      assert picture.rank == 42
      assert picture.sha1 == "some sha1"
      assert picture.width == 42
    end

    test "create_picture/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Galleries.create_picture(@invalid_attrs)
    end

    test "update_picture/2 with valid data updates the picture" do
      picture = picture_fixture()
      assert {:ok, %Picture{} = picture} = Galleries.update_picture(picture, @update_attrs)
      assert picture.external_id == "7488a646-e31f-11e4-aace-600308960668"
      assert picture.filesize == 43
      assert picture.format == "some updated format"
      assert picture.height == 43
      assert picture.name == "some updated name"
      assert picture.path == "some updated path"
      assert picture.rank == 43
      assert picture.sha1 == "some updated sha1"
      assert picture.width == 43
    end

    test "update_picture/2 with invalid data returns error changeset" do
      picture = picture_fixture()
      assert {:error, %Ecto.Changeset{}} = Galleries.update_picture(picture, @invalid_attrs)
      assert picture == Galleries.get_picture!(picture.id)
    end

    test "delete_picture/1 deletes the picture" do
      picture = picture_fixture()
      assert {:ok, %Picture{}} = Galleries.delete_picture(picture)
      assert_raise Ecto.NoResultsError, fn -> Galleries.get_picture!(picture.id) end
    end

    test "change_picture/1 returns a picture changeset" do
      picture = picture_fixture()
      assert %Ecto.Changeset{} = Galleries.change_picture(picture)
    end
  end

  describe "tags" do
    alias Regal.Galleries.Tag

    @valid_attrs %{color: "some color", description: "some description", name: "some name"}
    @update_attrs %{color: "some updated color", description: "some updated description", name: "some updated name"}
    @invalid_attrs %{color: nil, description: nil, name: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Galleries.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Galleries.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Galleries.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Galleries.create_tag(@valid_attrs)
      assert tag.color == "some color"
      assert tag.description == "some description"
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Galleries.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = Galleries.update_tag(tag, @update_attrs)
      assert tag.color == "some updated color"
      assert tag.description == "some updated description"
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Galleries.update_tag(tag, @invalid_attrs)
      assert tag == Galleries.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Galleries.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Galleries.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Galleries.change_tag(tag)
    end
  end


  @doc """

  describe "picture_tags" do
    alias Regal.Galleries.PictureTag

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def picture_tag_fixture(attrs \\ %{}) do
      {:ok, picture_tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Galleries.create_picture_tag()

      picture_tag
    end

    test "list_picture_tags/0 returns all picture_tags" do
      picture_tag = picture_tag_fixture()
      assert Galleries.list_picture_tags() == [picture_tag]
    end

    test "get_picture_tag!/1 returns the picture_tag with given id" do
      picture_tag = picture_tag_fixture()
      assert Galleries.get_picture_tag!(picture_tag.id) == picture_tag
    end

    test "create_picture_tag/1 with valid data creates a picture_tag" do
      assert {:ok, %PictureTag{} = picture_tag} = Galleries.create_picture_tag(@valid_attrs)
    end

    test "create_picture_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Galleries.create_picture_tag(@invalid_attrs)
    end

    test "update_picture_tag/2 with valid data updates the picture_tag" do
      picture_tag = picture_tag_fixture()
      assert {:ok, %PictureTag{} = picture_tag} = Galleries.update_picture_tag(picture_tag, @update_attrs)
    end

    test "update_picture_tag/2 with invalid data returns error changeset" do
      picture_tag = picture_tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Galleries.update_picture_tag(picture_tag, @invalid_attrs)
      assert picture_tag == Galleries.get_picture_tag!(picture_tag.id)
    end

    test "delete_picture_tag/1 deletes the picture_tag" do
      picture_tag = picture_tag_fixture()
      assert {:ok, %PictureTag{}} = Galleries.delete_picture_tag(picture_tag)
      assert_raise Ecto.NoResultsError, fn -> Galleries.get_picture_tag!(picture_tag.id) end
    end

    test "change_picture_tag/1 returns a picture_tag changeset" do
      picture_tag = picture_tag_fixture()
      assert %Ecto.Changeset{} = Galleries.change_picture_tag(picture_tag)
    end
  end



  describe "gallery_pictures" do
    alias Regal.Galleries.GalleryPicture

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def gallery_picture_fixture(attrs \\ %{}) do
      {:ok, gallery_picture} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Galleries.create_gallery_picture()

      gallery_picture
    end

    test "list_gallery_pictures/0 returns all gallery_pictures" do
      gallery_picture = gallery_picture_fixture()
      assert Galleries.list_gallery_pictures() == [gallery_picture]
    end

    test "get_gallery_picture!/1 returns the gallery_picture with given id" do
      gallery_picture = gallery_picture_fixture()
      assert Galleries.get_gallery_picture!(gallery_picture.id) == gallery_picture
    end

    test "create_gallery_picture/1 with valid data creates a gallery_picture" do
      assert {:ok, %GalleryPicture{} = gallery_picture} = Galleries.create_gallery_picture(@valid_attrs)
    end

    test "create_gallery_picture/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Galleries.create_gallery_picture(@invalid_attrs)
    end

    test "update_gallery_picture/2 with valid data updates the gallery_picture" do
      gallery_picture = gallery_picture_fixture()
      assert {:ok, %GalleryPicture{} = gallery_picture} = Galleries.update_gallery_picture(gallery_picture, @update_attrs)
    end

    test "update_gallery_picture/2 with invalid data returns error changeset" do
      gallery_picture = gallery_picture_fixture()
      assert {:error, %Ecto.Changeset{}} = Galleries.update_gallery_picture(gallery_picture, @invalid_attrs)
      assert gallery_picture == Galleries.get_gallery_picture!(gallery_picture.id)
    end

    test "delete_gallery_picture/1 deletes the gallery_picture" do
      gallery_picture = gallery_picture_fixture()
      assert {:ok, %GalleryPicture{}} = Galleries.delete_gallery_picture(gallery_picture)
      assert_raise Ecto.NoResultsError, fn -> Galleries.get_gallery_picture!(gallery_picture.id) end
    end

    test "change_gallery_picture/1 returns a gallery_picture changeset" do
      gallery_picture = gallery_picture_fixture()
      assert %Ecto.Changeset{} = Galleries.change_gallery_picture(gallery_picture)
    end
  end

  """

end
