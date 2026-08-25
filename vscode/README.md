# VS Code

Settings, keybindings, and extensions for the **default profile** — not a named
one. The default profile lives at a fixed path
(`~/Library/Application Support/Code/User/`), so applying it is a plain copy.

This folder sits outside `home/` deliberately: VS Code rewrites `settings.json`
whenever you toggle anything in the UI, so tracking it with chezmoi would mean
permanent `chezmoi status` drift. The two scripts below make syncing explicit
instead.

- `settings.json` — editor settings (Min Dark theme, vscode-neovim, formatter defaults, debugger tweaks)
- `keybindings.json` — keybindings (currently empty)
- `extensions.txt` — extension IDs, one per line

## New machine

```sh
./vscode/apply.sh          # install extensions + copy settings/keybindings
./vscode/apply.sh --prune  # ...and uninstall anything not in extensions.txt
```

Needs the `code` CLI (`cask "visual-studio-code"` in the Brewfile provides it;
if it's still missing, run *Shell Command: Install 'code' command in PATH* from
inside VS Code).

Use `--prune` on a machine that already had VS Code set up — it clears
extensions that conflict with this config, notably `vscodevim.vim`, which
fights `asvetliakov.vscode-neovim` if both are installed.

Existing `settings.json` / `keybindings.json` are copied to `*.json.bak` before
being overwritten. Restart VS Code afterwards.

## Updating the repo after changing settings in VS Code

```sh
./vscode/sync.sh
```

Copies the live default profile back into this folder — then review and commit.
