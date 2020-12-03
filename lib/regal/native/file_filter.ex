defmodule Regal.Native.FileFilter do
  defstruct [
    file_type_filter: nil,
    regex_filter: nil,
    exclude: false,
  ]

  @type t() :: %__MODULE__{
    file_type_filter: String.t() | nil,
    regex_filter: String.t() | nil,
    exclude: boolean() | nil,
  }

end