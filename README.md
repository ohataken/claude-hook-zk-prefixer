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
OBSIDIAN_VAULT_PATH=/path/to/vault claude-hook-zk-prefixer '%Y-%m-%dT%H%M%S'
```

stdin is parsed as JSON and written as YAML frontmatter to
`<vault>/<formatted time>.md` at the vault top level, so Obsidian shows the
payload as note properties.

```markdown
---
cwd: /path/to/project
hook_event_name: SessionStart
session_id: 491fe83a-d410-4d20-a532-4dcb0b3bbd4e
source: startup
---
```

### environment variables

| variable | description |
|---|---|
| `OBSIDIAN_VAULT_PATH` | path to the Obsidian vault. required |

### arguments

| argument | description |
|---|---|
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
        "matcher": "startup",
        "hooks": [
          {
            "type": "command",
            "command": "OBSIDIAN_VAULT_PATH=/path/to/vault claude-hook-zk-prefixer '%Y-%m-%dT%H%M%S'"
          }
        ]
      }
    ]
  }
}
```

`SessionStart` also fires on `resume`, `clear` and `compact`. The `startup`
matcher keeps it to fresh sessions only, so resuming a session does not add
another note.
