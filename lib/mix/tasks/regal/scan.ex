defmodule Mix.Tasks.Regal.Scan do
  use Mix.Task

  alias Regal.TaskHelper

  def run(_ \\ []) do
    Logger.configure([level: :info])
    TaskHelper.start_ecto()
    TaskHelper.start_poolboy()

    IO.puts("\nLooking for files to index...")
    errors = Regal.Galleries.index_all_galleries()
             |> Enum.filter(fn element -> element != nil && element != :ok end)
    summary = if !Enum.empty?(errors) do
                "Errors: #{errors}"
              else
                "Ok, i'm done here"
              end
    IO.puts(summary)
  end
end