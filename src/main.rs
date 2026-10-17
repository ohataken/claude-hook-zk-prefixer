use chrono::Local;
use serde::Deserialize;
use serde::de::DeserializeOwned;
use std::path::PathBuf;

#[derive(Deserialize)]
struct SessionStart {
    session_id: String,
    transcript_path: String,
    cwd: String,
    hook_event_name: String,
    source: String,
}

impl SessionStart {
    fn frontmatter(&self) -> String {
        format!(
            "session_id: {}\ntranscript_path: {}\ncwd: {}\nhook_event_name: {}\nsource: {}\n",
            self.session_id,
            quote(&self.transcript_path),
            quote(&self.cwd),
            self.hook_event_name,
            self.source,
        )
    }
}

fn main() {
    let vault_path = vault_path();
    let note_name_format = note_name_format();

    let frontmatter = read_payload::<SessionStart>().frontmatter();
    let content = format!("---\n{}---\n", frontmatter);

    let file_name = format!("{}.md", Local::now().format(&note_name_format));
    let note_path = vault_path.join(file_name);

    std::fs::write(&note_path, content).expect("failed to write note");
}

fn read_payload<T: DeserializeOwned>() -> T {
    serde_json::from_reader(std::io::stdin()).expect("failed to parse JSON from stdin")
}

fn quote(value: &str) -> String {
    serde_json::to_string(value).expect("failed to quote string")
}

fn vault_path() -> PathBuf {
    let vault_path = std::env::var("OBSIDIAN_VAULT_PATH").expect("OBSIDIAN_VAULT_PATH is not set");

    PathBuf::from(vault_path)
}

fn hook_event() -> String {
    std::env::args().nth(1).expect("hook event is not given")
}

fn note_name_format() -> String {
    std::env::args()
        .nth(2)
        .unwrap_or_else(|| "%Y%m%d%H%M".to_string())
}
