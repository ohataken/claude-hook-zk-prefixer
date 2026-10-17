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
session_id: 491fe83a-d410-4d20-a532-4dcb0b3bbd4e
transcript_path: "/path/to/transcript.jsonl"
cwd: "/path/to/project"
hook_event_name: SessionStart
source: startup
---
```

Any other field in the payload is left out.

### environment variables

| variable | description |
|---|---|
| `OBSIDIAN_VAULT_PATH` | path to the Obsidian vault. required |

### arguments

| argument | description |
|---|---|
| hook event | the hook event the payload comes from. only `session_start` for now. required |
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
    ]
  }
}
```
