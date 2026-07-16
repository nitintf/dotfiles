#!/usr/bin/env bash
# Pull the live "Nitin's setup" profile from this machine back into the repo,
# so changes made in VS Code can be committed.
set -euo pipefail

PROFILE="Nitin's setup"
DIR="$(cd "$(dirname "$0")" && pwd)"
USER_DIR="$HOME/Library/Application Support/Code/User"

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
  echo "Profile '$PROFILE' not found on this machine." >&2
  exit 1
fi

SRC="$USER_DIR/profiles/$LOCATION"
cp "$SRC/settings.json" "$SRC/keybindings.json" "$DIR/"

python3 - "$SRC/extensions.json" "$DIR/extensions.txt" <<'EOF'
import json, sys
exts = json.load(open(sys.argv[1]))
ids = sorted(e["identifier"]["id"] for e in exts)
open(sys.argv[2], "w").write("\n".join(ids) + "\n")
EOF

echo "Synced settings, keybindings, and $(wc -l < "$DIR/extensions.txt" | tr -d ' ') extensions from '$PROFILE'"
git -C "$DIR" status --short -- .
