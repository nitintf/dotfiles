# MacOS Dotfiles

This repository contains my personal dotfiles for macOS, managed with [chezmoi](https://www.chezmoi.io/). These are the base settings I use to set up a new Mac's development environment. It includes everything I need to create a productive workspace.

## Installation

This repository uses [chezmoi](https://www.chezmoi.io/) for dotfile management. To install:

1. Install chezmoi (if not already installed):
2. Initialize and apply the dotfiles:

## Toolchain

Language runtimes — node, python, go, rust — are managed by
[mise](https://mise.jdx.dev), not Homebrew, so versions are per-project.
The global pins live in [`home/dot_config/mise/config.toml`](home/dot_config/mise/config.toml);
existing `.nvmrc` files are honoured. Everything else comes from
[`home/Brewfile`](home/Brewfile).

Shell extras wired up in `config.fish`: [atuin](https://atuin.sh) owns `ctrl-r`
for history search, and [delta](https://github.com/dandavison/delta) renders
every `git diff` (and lazygit's).

## VS Code

Settings, keybindings, and extensions for the **default** VS Code profile live
in [`vscode/`](vscode/) and are applied separately from chezmoi:

```sh
./vscode/apply.sh
```

See [vscode/README.md](vscode/README.md) for details, including `--prune`.
