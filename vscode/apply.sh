#!/usr/bin/env bash
# Recreate the "Nitin's setup" VS Code profile on this machine:
# installs all extensions into the profile, then copies settings + keybindings.
set -euo pipefail

PROFILE="Nitin's setup"
DIR="$(cd "$(dirname "$0")" && pwd)"
USER_DIR="$HOME/Library/Application Support/Code/User"

if ! command -v code >/dev/null; then
  echo "'code' CLI not found — in VS Code run: Shell Command: Install 'code' command in PATH" >&2
  exit 1
fi

while read -r ext; do
  [ -n "$ext" ] && code --profile "$PROFILE" --install-extension "$ext"
done < "$DIR/extensions.txt"

# VS Code assigns the profile a random directory name; look it up in storage.json
LOCATION=$(python3 - "$PROFILE" "$USER_DIR/globalStorage/storage.json" <<'EOF'
import json, sys
name, path = sys.argv[1], sys.argv[2]
for p in json.load(open(path)).get("userDataProfiles", []):
    if p["name"] == name:
        print(p["location"])
        break
EOF
)

if [ -z "$LOCATION" ]; then
  echo "Profile '$PROFILE' not registered yet — open VS Code once, then re-run this script." >&2
  exit 1
fi

cp "$DIR/settings.json" "$DIR/keybindings.json" "$USER_DIR/profiles/$LOCATION/"
echo "Done: extensions installed, settings + keybindings applied to '$PROFILE' ($LOCATION)"
