use std::fs::read_dir;

#[derive(NifStruct)]
#[module = "Regal.Scanner.FileFilter"]
pub struct FileFilter {
    pub file_type_filter: Option<String>,
    pub regex_filter: Option<String>,
    pub exclude: bool,
}

#[derive(NifStruct)]
#[module = "Regal.Scanner.Filters"]
pub struct Filters {
    pub file_filters: Vec<FileFilter>,
    pub directory_filters: Vec<FileFilter>,
}

impl Filters {
    fn accepts_file(&self, _path: &str) -> bool {
        true
    }
    fn accepts_directory(&self, _path: &str) -> bool {
        true
    }
}

enum ScannerError {
    Io(std::io::Error),
}

impl From<ScannerError> for String {
    fn from(e: ScannerError) -> String {
        match e {
            ScannerError::Io(io) => io.to_string(),
        }
    }
}

impl From<std::io::Error> for ScannerError {
    fn from(io: std::io::Error) -> Self {
        ScannerError::Io(io)
    }
}

pub fn scan(folder: &str, filters: &Filters) -> Result<Vec<String>, String> {
    println!("Scanning {}", folder);
    Ok(find_files(&folder, &folder, &filters)?)
}

fn find_files(root: &str, folder: &str, filters: &Filters) -> Result<Vec<String>, ScannerError> {
    let mut files = vec![];
    let dir = read_dir(folder)?;

    for r in dir {
        if let Ok(entry) = r {
            let path = entry.path();
            let path_str = path.to_str().unwrap();
            let sub_path = &path_str[root.len()+1..];
            if path.is_dir() && filters.accepts_directory(sub_path) {
                let mut internals = find_files(&root, &path_str, &filters)?;
                files.append(&mut internals);
            } else if path.is_file() && filters.accepts_file(sub_path) {
                files.push(path_str.into());
            }
        }
    }
    Ok(files)
}