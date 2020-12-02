defmodule Regal.Native do
    use Rustler, otp_app: :regal, crate: "regal_native"

    def initiazile do
        db_user = Application.get_env(:regal, Regal.Repo)[:username]
        db_pass = Application.get_env(:regal, Regal.Repo)[:password]
        init(db_user, db_pass)
    end
    
  # When your NIF is loaded, it will override this function.
    def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)

    def init(_u, _p), do: :erlang.nif_error(:nif_not_loaded)

    def scan(_p, _t), do: :erlang.nif_error(:nif_not_loaded)
end