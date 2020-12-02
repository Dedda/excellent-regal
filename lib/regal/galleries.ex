defmodule Regal.Galleries do
  @moduledoc """
  The Galleries context.
  """

  import Ecto.Query, warn: false
  alias Regal.Repo

  alias Regal.Galleries.Gallery

  @doc """
  Returns the list of galleries.

  ## Examples

      iex> list_galleries()
      [%Gallery{}, ...]

  """
  def list_galleries do
    Repo.all(Gallery)
  end

  @doc """
  Gets a single gallery.

  Raises `Ecto.NoResultsError` if the Gallery does not exist.

  ## Examples

      iex> get_gallery!(123)
      %Gallery{}

      iex> get_gallery!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gallery!(id), do: Repo.get!(Gallery, id)

  @doc """
  Creates a gallery.

  ## Examples

      iex> create_gallery(%{field: value})
      {:ok, %Gallery{}}

      iex> create_gallery(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gallery(attrs \\ %{}) do
    %Gallery{}
    |> Gallery.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gallery.

  ## Examples

      iex> update_gallery(gallery, %{field: new_value})
      {:ok, %Gallery{}}

      iex> update_gallery(gallery, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gallery(%Gallery{} = gallery, attrs) do
    gallery
    |> Gallery.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gallery.

  ## Examples

      iex> delete_gallery(gallery)
      {:ok, %Gallery{}}

      iex> delete_gallery(gallery)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gallery(%Gallery{} = gallery) do
    Repo.delete(gallery)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gallery changes.

  ## Examples

      iex> change_gallery(gallery)
      %Ecto.Changeset{data: %Gallery{}}

  """
  def change_gallery(%Gallery{} = gallery, attrs \\ %{}) do
    Gallery.changeset(gallery, attrs)
  end

  alias Regal.Galleries.Picture

  @doc """
  Returns the list of pictures.

  ## Examples

      iex> list_pictures()
      [%Picture{}, ...]

  """
  def list_pictures do
    Repo.all(Picture)
  end

  @doc """
  Gets a single picture.

  Raises `Ecto.NoResultsError` if the Picture does not exist.

  ## Examples

      iex> get_picture!(123)
      %Picture{}

      iex> get_picture!(456)
      ** (Ecto.NoResultsError)

  """
  def get_picture!(id), do: Repo.get!(Picture, id)

  @doc """
  Creates a picture.

  ## Examples

      iex> create_picture(%{field: value})
      {:ok, %Picture{}}

      iex> create_picture(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_picture(attrs \\ %{}) do
    %Picture{}
    |> Picture.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a picture.

  ## Examples

      iex> update_picture(picture, %{field: new_value})
      {:ok, %Picture{}}

      iex> update_picture(picture, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_picture(%Picture{} = picture, attrs) do
    picture
    |> Picture.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a picture.

  ## Examples

      iex> delete_picture(picture)
      {:ok, %Picture{}}

      iex> delete_picture(picture)
      {:error, %Ecto.Changeset{}}

  """
  def delete_picture(%Picture{} = picture) do
    Repo.delete(picture)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking picture changes.

  ## Examples

      iex> change_picture(picture)
      %Ecto.Changeset{data: %Picture{}}

  """
  def change_picture(%Picture{} = picture, attrs \\ %{}) do
    Picture.changeset(picture, attrs)
  end

  alias Regal.Galleries.Tag

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags do
    Repo.all(Tag)
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{data: %Tag{}}

  """
  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  alias Regal.Galleries.PictureTag

  @doc """
  Returns the list of picture_tags.

  ## Examples

      iex> list_picture_tags()
      [%PictureTag{}, ...]

  """
  def list_picture_tags do
    Repo.all(PictureTag)
  end

  @doc """
  Gets a single picture_tag.

  Raises `Ecto.NoResultsError` if the Picture tag does not exist.

  ## Examples

      iex> get_picture_tag!(123)
      %PictureTag{}

      iex> get_picture_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_picture_tag!(id), do: Repo.get!(PictureTag, id)

  @doc """
  Creates a picture_tag.

  ## Examples

      iex> create_picture_tag(%{field: value})
      {:ok, %PictureTag{}}

      iex> create_picture_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_picture_tag(attrs \\ %{}) do
    %PictureTag{}
    |> PictureTag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a picture_tag.

  ## Examples

      iex> update_picture_tag(picture_tag, %{field: new_value})
      {:ok, %PictureTag{}}

      iex> update_picture_tag(picture_tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_picture_tag(%PictureTag{} = picture_tag, attrs) do
    picture_tag
    |> PictureTag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a picture_tag.

  ## Examples

      iex> delete_picture_tag(picture_tag)
      {:ok, %PictureTag{}}

      iex> delete_picture_tag(picture_tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_picture_tag(%PictureTag{} = picture_tag) do
    Repo.delete(picture_tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking picture_tag changes.

  ## Examples

      iex> change_picture_tag(picture_tag)
      %Ecto.Changeset{data: %PictureTag{}}

  """
  def change_picture_tag(%PictureTag{} = picture_tag, attrs \\ %{}) do
    PictureTag.changeset(picture_tag, attrs)
  end
end
