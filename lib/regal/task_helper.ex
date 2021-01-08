defmodule Regal.TaskHelper do

  def start_ecto do
    [:postgrex, :ecto]
    |> Enum.each(&Application.ensure_all_started/1)
    Regal.Repo.start_link()
  end

  def start_poolboy do
    opts = [strategy: :one_for_one, name: Regal.Supervisor]
    spec = :poolboy.child_spec(:thumbs_worker, Regal.Application.thumbs_boy_config())
    Supervisor.start_link([spec], opts)
  end
end