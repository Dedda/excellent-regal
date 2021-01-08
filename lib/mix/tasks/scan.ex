defmodule Mix.Tasks.Scan do
  use Mix.Task

  alias Regal.TaskHelper

  @shortdoc ""
  def run(_) do
    TaskHelper.start_ecto()
    TaskHelper.start_poolboy()

    errors = Regal.Galleries.index_all_galleries()
             |> Enum.filter(fn element -> element != nil && element != :ok end)
    IO.puts("Errors: #{errors}")
  end
end