defmodule Regal.NativeTest do
  use ExUnit.Case

  alias Regal.Native

  describe "native" do
    test "add 2 + 3 = 5" do
      assert Native.add(2, 3) == {:ok, 5}
    end

    test "init" do
      assert Native.initiazile() == :ok
    end
  end
end