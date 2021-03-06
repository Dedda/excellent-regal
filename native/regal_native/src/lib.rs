extern crate image;
#[macro_use]
extern crate rustler;
extern crate uuid;

use rustler::{Encoder, Env, Error, Term};

mod thumbs;

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
        ("scan_picture", 4, scan_picture),
        ("thumb_picture", 4, thumb_picture),
    ],
    Some(on_load)
}

fn on_load(env: Env, _info: Term) -> bool {
    resource_struct_init!(thumbs::ScannedImage, env);
    true
}

fn scan_picture<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let src_path: String = args[0].decode()?;
    let thumb_path: String = args[1].decode()?;
    let width: usize = args[2].decode()?;
    let height: usize = args[3].decode()?;
    let thumb = thumbs::scan_picture(&src_path, &thumb_path, (width, height));
    Ok(match thumb {
        Ok(scanned) => (atoms::ok(), scanned).encode(env),
        Err(msg) => (atoms::error(), String::from(msg)).encode(env),
    })
}

fn thumb_picture<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let src_path: String = args[0].decode()?;
    let thumb_path: String = args[1].decode()?;
    let width: usize = args[2].decode()?;
    let height: usize = args[3].decode()?;
    let thumb = thumbs::create_thumb(&src_path, &thumb_path, (width, height));
    Ok(match thumb {
        Ok(()) => (atoms::ok()).encode(env),
        Err(msg) => (atoms::error(), String::from(msg)).encode(env),
    })
}

pub fn format_from_path(path: &str) -> &'static str {
    if path.split("/").last().unwrap_or("").contains(".") {
        match path.to_lowercase().split(".").last() {
            Some("png") => "png",
            Some("jpg") | Some("jpeg") => "jpeg",
            _ => "",
        }
    } else {
        ""
    }
}

#[cfg(test)]
mod tests {
    use crate::format_from_path;

    #[test]
    fn format_from_path_with_extension() {
        assert_eq!("png", format_from_path("picture.png"));
        assert_eq!("jpeg", format_from_path("picture.jpg"));
        assert_eq!("jpeg", format_from_path("picture.jpeg"));
    }

    #[test]
    fn format_from_path_without_extension() {
        assert_eq!("", format_from_path("picturepng"));
        assert_eq!("", format_from_path("picturejpg"));
        assert_eq!("", format_from_path("jpeg"));
    }
}