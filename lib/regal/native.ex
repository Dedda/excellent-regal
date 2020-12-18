defmodule Regal.Native do
    use Rustler, otp_app: :regal, crate: "regal_native"

    alias Regal.Native.ScannedImage

    #    def scan_picture(p) do
    #        IO.inspect(["Scanning pic: ", p])
    #        {:ok, %ScannedImage{
    #            format: "png",
    #            width: 1,
    #            height: 1,
    #        }}
    #    end

    @spec scan_picture(String.t, String.t, integer, integer) :: tuple()
    def scan_picture(_s, _d, _w, _h), do: :erlang.nif_error(:nif_not_loaded)

end