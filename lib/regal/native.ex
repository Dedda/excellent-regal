defmodule Regal.Native do
    use Rustler, otp_app: :regal, crate: "regal_native"

    @spec scan_picture(String.t, String.t, integer, integer) :: tuple()
    def scan_picture(_s, _d, _w, _h), do: :erlang.nif_error(:nif_not_loaded)

    @spec thumb_picture(String.t, String.t, integer, integer) :: tuple()
    def thumb_picture(_s, _d, _w, _h), do: :erlang.nif_error(:nif_not_loaded)
    
end