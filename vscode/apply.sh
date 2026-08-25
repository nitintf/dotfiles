#!/usr/bin/env bash
# Apply this repo's VS Code config to the DEFAULT profile on this machine:
# installs every extension, then copies settings + keybindings into place.
#
# The default profile lives at a fixed path (unlike named profiles, which VS
# Code files under a random directory), so this is just a copy — no lookup.
#
#   ./apply.sh            install extensions listed in extensions.txt
#   ./apply.sh --prune    also uninstall anything NOT in extensions.txt
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
USER_DIR="$HOME/Library/Application Support/Code/User"
PRUNE=0
[ "${1:-}" = "--prune" ] && PRUNE=1

if ! command -v code >/dev/null; then
  echo "'code' CLI not found — in VS Code run: Shell Command: Install 'code' command in PATH" >&2
  exit 1
fi

# Extensions with no --profile go into the default profile.
while read -r ext; do
  [ -n "$ext" ] && code --force --install-extension "$ext"
done < "$DIR/extensions.txt"

if [ "$PRUNE" -eq 1 ]; then
  # Uninstall anything the repo doesn't list. Catches leftovers that conflict
  # with this setup (e.g. vscodevim.vim fighting asvetliakov.vscode-neovim).
  comm -23 <(code --list-extensions | sort) <(sort "$DIR/extensions.txt") |
    while read -r ext; do
      [ -n "$ext" ] && echo "Removing $ext" && code --uninstall-extension "$ext"
    done
fi

mkdir -p "$USER_DIR"
for f in settings.json keybindings.json; do
  # Keep one backup of whatever was there before, so this is undoable.
  [ -f "$USER_DIR/$f" ] && cp "$USER_DIR/$f" "$USER_DIR/$f.bak"
  cp "$DIR/$f" "$USER_DIR/$f"
done

echo "Done: extensions installed, settings + keybindings applied to the default profile."
echo "Restart VS Code to pick them up."
