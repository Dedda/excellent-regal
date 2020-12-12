extern crate bmp;
extern crate jpeg_decoder;
// #[macro_use]
extern crate lazy_static;
extern crate png;
extern crate regex;
#[macro_use]
extern crate rustler;
extern crate tiff;

use rustler::{Encoder, Env, Error, Term};
use crate::scanner::Filters;

mod scanner;

mod atoms {
    rustler_atoms! {
        atom ok;
        atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler::rustler_export_nifs! {
    "Elixir.Regal.Native",
    [
        ("init", 2, init),
        ("scan", 2, scan),
    ],
    Some(on_load)
}

fn on_load(env: Env, _info: Term) -> bool {
    resource_struct_init!(scanner::FileFilter, env);
    resource_struct_init!(scanner::Filters, env);
    true
}

fn init<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let _username: String = args[0].decode()?;
    let _password: String = args[1].decode()?;
    Ok((atoms::ok()).encode(env))
}

fn scan<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let path: String = args[0].decode()?;
    let filters: Filters = args[2].decode()?;
    let scanned = scanner::scan(&path, &filters);
    Ok(match scanned {
        Ok(files) => (atoms::ok(), files).encode(env),
        Err(msg) => (atoms::error(), msg).encode(env),
    })
}
