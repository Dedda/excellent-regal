defmodule Regal.ScannerTest do
  use ExUnit.Case

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
end