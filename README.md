# MacOS Dotfiles

This repository contains my personal dotfiles for macOS, managed with [chezmoi](https://www.chezmoi.io/). These are the base settings I use to set up a new Mac's development environment. It includes everything I need to create a productive workspace.

## Installation

This repository uses [chezmoi](https://www.chezmoi.io/) for dotfile management. To install:

1. Install chezmoi (if not already installed):
   ```sh
   # macOS with Homebrew
   brew install chezmoi
   
   # Or download from https://www.chezmoi.io/install/
   ```

2. Initialize and apply the dotfiles:
   ```sh
   chezmoi init nitintf
   chezmoi apply
   ```

## VS Code

The "Nitin's setup" VS Code profile (settings, keybindings, extensions) lives in [`vscode/`](vscode/) and is applied separately from chezmoi:

```sh
./vscode/apply.sh
```

See [vscode/README.md](vscode/README.md) for details.