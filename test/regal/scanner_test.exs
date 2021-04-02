defmodule Regal.ScannerTest do
  use Regal.DataCase, async: false

  alias Regal.Scanner

  describe "picture file name filter" do
    test "valid formats" do
      assert Scanner.accept_file("pic1.png")
      assert Scanner.accept_file("pic1.jpg")
      assert Scanner.accept_file("pic1.jpeg")
    end

    test "invalid formats" do
      assert !Scanner.accept_file("pic1.exe")
    end
  end

  describe "read file properties" do
    test "from jpg file" do
      {:ok, gallery_picture} = Scanner.index_picture!({"fixture_data/galleries/switzerland/IMG_20200728_112600.jpg", "IMG_20200728_112600.jpg", nil})
      picture = Regal.Galleries.get_picture!(gallery_picture.picture_id)
      %{
        width: width,
        height: height,
        external_id: external_id,
      } = picture
      assert 4208 == width
      assert 3120 == height
      File.rm!("test/data/#{external_id}.png")
    end
  end
end