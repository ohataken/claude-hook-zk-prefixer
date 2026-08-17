use chrono::Local;
use serde_json::Value;
use std::path::PathBuf;

fn main() {
    let vault_path = vault_path();
    let note_name_format = note_name_format();

    let payload: Value =
        serde_json::from_reader(std::io::stdin()).expect("failed to parse JSON from stdin");
    let content = serde_json::to_string_pretty(&payload).expect("failed to format JSON");

    let file_name = format!("{}.md", Local::now().format(&note_name_format));
    let note_path = vault_path.join(file_name);

    std::fs::write(&note_path, content + "\n").expect("failed to write note");
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
