defmodule Regal.Statistics do
  @moduledoc false

  alias Regal.Configuration
  alias Regal.FileHelper

  def thumbs_count do
    Configuration.get_thumbs_dir!()
    |> File.ls!()
    |> Enum.filter(&FileHelper.is_png?/1)
    |> length()
  end

  def thumbs_disk_usage do
    thumbs_dir = Configuration.get_thumbs_dir!()
    thumbs = thumbs_dir
             |> File.ls!()
             |> Enum.filter(&FileHelper.is_png?/1)
             |> Enum.map(fn name -> File.stat("#{thumbs_dir}/#{name}") end)
    thumbs
    |> Enum.map(
         fn stats ->
           case stats do
             {:ok, s} -> s.size
             _ -> 0
           end
         end
       )
    |> Enum.sum()
  end

end
