use crate::format_from_path;
use image::GenericImageView;
use uuid::Uuid;

#[derive(NifStruct)]
#[module = "Regal.Scanner.ScannedImage"]
pub struct ScannedImage {
    pub width: usize,
    pub height: usize,
    pub format: String,
    pub external_id: String,
}

pub enum ThumbsError {
    General(String),
    Io(std::io::Error),
    Image(image::ImageError),
}

impl From<ThumbsError> for String {
    fn from(e: ThumbsError) -> Self {
        match e {
            ThumbsError::General(s) => s,
            ThumbsError::Io(io) => io.to_string(),
            ThumbsError::Image(img) => img.to_string(),
        }
    }
}

impl From<std::io::Error> for ThumbsError {
    fn from(io: std::io::Error) -> Self {
        ThumbsError::Io(io)
    }
}


impl From<image::ImageError> for ThumbsError {
    fn from(e: image::ImageError) -> Self {
        ThumbsError::Image(e)
    }
}

pub fn create_thumb(src_path: &str, thumb_path: &str, size: (usize, usize)) -> Result<ScannedImage, ThumbsError> {
    let (width, height) = size;
    let pic = image::open(src_path)?;
    let external_id = Uuid::new_v4().to_simple().to_string();
    let thumb_path = format!("{}/{}.png", thumb_path, external_id);
    let thumb = pic.resize_to_fill(width as u32, height as u32, image::imageops::FilterType::Gaussian);
    thumb.save(thumb_path)?;
    Ok(ScannedImage {
        width: pic.width() as usize,
        height: pic.height() as usize,
        format: format_from_path(src_path).to_string(),
        external_id,
    })
}
