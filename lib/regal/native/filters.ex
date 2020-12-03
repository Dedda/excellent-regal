defmodule Regal.Native.Filters do
  @enforce_keys [:file_filters, :directory_filters]
  defstruct [
    file_filters: [],
    directory_filters: [],
  ]

  @type t() :: %__MODULE__{
    file_filters: list(Regal.Native.FileFilter.t()),
    directory_filters: list(Regal.Native.FileFilter.t()),
  }
end