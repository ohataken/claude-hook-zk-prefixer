# claude-hook-zk-prefixer

my little Claude Code hook for Obsidian.

Reads a Claude Code hook payload from stdin and saves it into an Obsidian vault
as a markdown note, named after the current time — the way Obsidian's
`zk-prefixer` core plugin names the notes it creates.

## installation

available on homebrew tap.

```sh
brew tap ohataken/claude-hook-zk-prefixer https://github.com/ohataken/claude-hook-zk-prefixer
brew trust ohataken/claude-hook-zk-prefixer
brew install claude-hook-zk-prefixer
```

## usage

```sh
OBSIDIAN_VAULT_PATH=/path/to/vault claude-hook-zk-prefixer session_start '%Y-%m-%dT%H%M%S'
```

stdin is parsed as the payload of the given hook event and its fields are
written as YAML frontmatter to `<vault>/<formatted time>.md` at the vault top
level, so Obsidian shows them as note properties.

```markdown
---
session_id: "[[491fe83a-d410-4d20-a532-4dcb0b3bbd4e]]"
transcript_path: "/path/to/transcript.jsonl"
cwd: "/path/to/project"
hook_event_name: SessionStart
source: startup
---
```

`session_end` writes `reason` in place of `source`. Any other field in the
payload is left out.

`user_prompt_submit` writes the common fields as frontmatter and the prompt as
the note body.

```markdown
---
session_id: "[[491fe83a-d410-4d20-a532-4dcb0b3bbd4e]]"
transcript_path: "/path/to/transcript.jsonl"
cwd: "/path/to/project"
hook_event_name: UserPromptSubmit
---

the prompt as typed
```

`stop` writes Claude's last response, `last_assistant_message`, as the note
body in the same way.

`session_id` is written as a wikilink, so the note links to `<session_id>.md`
anywhere in the vault — the note
[claude-hook-session-id-note](https://github.com/ohataken/claude-hook-session-id-note)
creates. That note then lists every note of the session in its backlinks. The
link stays unresolved until such a note exists.

### environment variables

| variable | description |
|---|---|
| `OBSIDIAN_VAULT_PATH` | path to the Obsidian vault. required |

### arguments

| argument | description |
|---|---|
| hook event | `session_start`, `session_end`, `user_prompt_submit` or `stop`, the hook event the payload comes from. required |
| format | note name format. defaults to `%Y%m%d%H%M` |

The format is [chrono](https://docs.rs/chrono/latest/chrono/format/strftime/index.html)
strftime, not the moment.js tokens Obsidian uses. Translate what `zk-prefixer`
has in its settings:

| zk-prefixer | this tool |
|---|---|
| `YYYYMMDDHHmm` | `%Y%m%d%H%M` |
| `YYYY-MM-DDTHHmmss` | `%Y-%m-%dT%H%M%S` |
| `YYYY-MM-DD` | `%Y-%m-%d` |

A moment.js format passed as is produces a literal file name, so every note
would overwrite the previous one.

`user_prompt_submit` and `stop` fire on every turn, so a format without seconds
makes notes written within the same minute overwrite each other.

### .claude/settings.json example

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "OBSIDIAN_VAULT_PATH=/path/to/vault claude-hook-zk-prefixer session_start '%Y-%m-%dT%H%M%S'"
          }
        ]
      }
    ],
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "OBSIDIAN_VAULT_PATH=/path/to/vault claude-hook-zk-prefixer user_prompt_submit '%Y-%m-%dT%H%M%S'"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "OBSIDIAN_VAULT_PATH=/path/to/vault claude-hook-zk-prefixer stop '%Y-%m-%dT%H%M%S'"
          }
        ]
      }
    ],
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "OBSIDIAN_VAULT_PATH=/path/to/vault claude-hook-zk-prefixer session_end '%Y-%m-%dT%H%M%S'"
          }
        ]
      }
    ]
  }
}
```
