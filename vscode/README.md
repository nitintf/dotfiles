# VS Code — "Nitin's setup" profile

Settings, keybindings, and extensions for my VS Code profile. This folder lives
outside `home/` on purpose — VS Code stores profiles under a random,
machine-specific directory (e.g. `profiles/-4dd397e3/`), so chezmoi can't
target it directly. The scripts below handle it instead.

- `settings.json` — editor settings (Min Dark theme, vscode-neovim, which-key leader menu, debugger tweaks)
- `keybindings.json` — profile keybindings (`<space>` opens the which-key menu)
- `extensions.txt` — all extension IDs, one per line

## New machine

```sh
./vscode/apply.sh
```

Installs every extension into the "Nitin's setup" profile (creating it if
needed) and copies settings + keybindings into place. If the profile isn't
registered yet, open VS Code once and re-run.

## Updating the repo after changing settings in VS Code

```sh
./vscode/sync.sh
```

Copies the live profile back into this folder — then review and commit.
