use std::path::PathBuf;

fn main() {
    vault_path();
}

fn vault_path() -> PathBuf {
    let vault_path = std::env::var("OBSIDIAN_VAULT_PATH").expect("OBSIDIAN_VAULT_PATH is not set");

    PathBuf::from(vault_path)
}

fn note_name_format() -> String {
    std::env::args()
        .nth(1)
        .unwrap_or_else(|| "%Y%m%d%H%M".to_string())
}
