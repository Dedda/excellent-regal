defmodule Regal.Worker.ThumbsWorker do
  use GenServer

  alias Regal.Native

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:generate_thumb, src, dest, {w, h}}, _from, state) do
    if !File.exists?(dest) do
      Native.thumb_picture(src, dest, w, h)
      {:reply, :ok, state}
    else
      {:reply, :already_exists, state}
    end
  end
end