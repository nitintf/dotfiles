set -g fish_greeting ""

# Variables
set -x GPG_TTY (tty)
set -x EDITOR nvim
set -x DOTNET_CLI_TELEMETRY_OPTOUT 1
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_AUTO_UPDATE 1
set -gx GOPATH "$HOME/go"
fish_add_path "$GOPATH/bin"
set fish_color_param cyan
set fish_pager_color_completion blue --bold
set fish_color_normal cyan
set fish_color_error red
set fish_color_comment gray
set fish_color_autosuggestion gray

# Paths — guard brew-specific ones (Apple Silicon). On Intel, brew is at /usr/local.
if test -d /opt/homebrew/bin
  fish_add_path /opt/homebrew/bin
  fish_add_path /opt/homebrew/sbin
end
test -d "$HOME/.cargo/bin"; and fish_add_path "$HOME/.cargo/bin"
test -d "$HOME/.local/share/nvim/mason/bin"; and fish_add_path "$HOME/.local/share/nvim/mason/bin"

source $HOME/.config/fish/fzf.fish
source $HOME/.config/fish/aliases.fish
source $HOME/.config/fish/functions.fish

# Starship reads config from $STARSHIP_CONFIG; keep the file under ~/.config/starship/
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"

if status is-interactive
  # Guarded like the rest: if brew bundle only half-finished, a missing tool
  # should not error on every single shell start.
  type -q starship; and starship init fish | source

  # mise — node/python/go/rust versions, per project. Must come before any
  # tool that shells out to a runtime.
  type -q mise; and mise activate fish | source

  # atuin — replaces ctrl-r with a searchable history database.
  # --disable-up-arrow keeps fish's own prefix search on the up key.
  type -q atuin; and atuin init fish --disable-up-arrow | source

  # zoxide — `z <dir>` jumps by frecency, `zi` picks with fzf.
  type -q zoxide; and zoxide init fish | source

  # PatrickF1/fzf.fish also wants ctrl-r. Re-install its bindings with the
  # history one omitted so atuin keeps the key; the rest (ctrl-alt-f/l/s/p/v)
  # stay as they are.
  type -q fzf_configure_bindings; and fzf_configure_bindings --history=
end

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
fish_add_path "$PNPM_HOME"

# Java (Zulu 17, for Android/Gradle builds)
if test -d /Library/Java/JavaVirtualMachines/zulu-17.jdk
  set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
end

# Android SDK
if test -d "$HOME/Library/Android/sdk"
  set -gx ANDROID_HOME "$HOME/Library/Android/sdk"
  fish_add_path "$ANDROID_HOME/emulator"
  fish_add_path "$ANDROID_HOME/platform-tools"
end

# Local user bin
fish_add_path "$HOME/.local/bin"

# Antigravity (if installed on this machine)
if test -d "$HOME/.antigravity/antigravity/bin"
  fish_add_path "$HOME/.antigravity/antigravity/bin"
end
