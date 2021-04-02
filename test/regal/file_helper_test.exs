defmodule FileHelperTest do
  use ExUnit.Case

  alias Regal.FileHelper

  describe "file types" do
    test "file extension" do
      assert "png" == FileHelper.extension("/data/test.png")
      assert "jpg" == FileHelper.extension("test.jpg")
    end
    
    test "check for png type" do
      assert true == FileHelper.is_png?("/data/test.png")
      assert true == FileHelper.is_png?("test.png")
      assert false == FileHelper.is_png?("test.jpg")
    end
  end
  
end
