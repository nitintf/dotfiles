#!/usr/bin/env bash
# Pull the live default-profile config from this machine back into the repo,
# so changes made in VS Code can be reviewed and committed.
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
USER_DIR="$HOME/Library/Application Support/Code/User"

if ! command -v code >/dev/null; then
  echo "'code' CLI not found — in VS Code run: Shell Command: Install 'code' command in PATH" >&2
  exit 1
fi

for f in settings.json keybindings.json; do
  if [ -f "$USER_DIR/$f" ]; then
    cp "$USER_DIR/$f" "$DIR/$f"
  else
    echo "⚠️  $USER_DIR/$f does not exist — leaving repo copy untouched." >&2
  fi
done

code --list-extensions | sort > "$DIR/extensions.txt"

echo "Synced settings, keybindings, and $(wc -l < "$DIR/extensions.txt" | tr -d ' ') extensions from the default profile."
git -C "$DIR" status --short -- .
