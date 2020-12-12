defmodule Regal.NativeTest do
  use ExUnit.Case

  alias Regal.Native

  describe "native" do

    test "init" do
      assert Native.initiazile() == :ok
    end
  end
end