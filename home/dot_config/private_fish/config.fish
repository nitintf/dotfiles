set -u fish_greeting ""

# Variables
set -x GPG_TTY (tty)
set -x EDITOR nvim
set -x DOTNET_CLI_TELEMETRY_OPTOUT 1
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_AUTO_UPDATE 1
set -x _ZO_DATA_DIR "$HOME/.local/share"
set -x TERM screen-256color
set -gx GO111MODULE on
set -gx GOPATH "$HOME/go"
fish_add_path "$GOPATH/bin"
test -d /usr/local/go/bin; and fish_add_path /usr/local/go/bin
set fish_color_param cyan
set fish_pager_color_completion blue --bold
set fish_color_normal cyan
set fish_color_error red
set fish_color_comment gray
set fish_color_autosuggestion gray

if [ "$macOS_Theme" = light ]
    set -x LS_COLORS "vivid generate $HOME/.config/vivid/onelight.yml"
else if [ "$macOS_Theme" = dark ]
    set -x LS_COLORS "vivid generate $HOME/.config/vivid/onedark.yml"
end

# Paths — guard brew-specific ones (Apple Silicon). On Intel, brew is at /usr/local.
if test -d /opt/homebrew/bin
  fish_add_path /opt/homebrew/bin
  fish_add_path /opt/homebrew/sbin
end
test -d "$HOME/.cargo/bin"; and fish_add_path "$HOME/.cargo/bin"
test -d "$HOME/.dotfiles/bin"; and fish_add_path "$HOME/.dotfiles/bin"
test -d "$HOME/.local/share/nvim/mason/bin"; and fish_add_path "$HOME/.local/share/nvim/mason/bin"
test -d /opt/homebrew/opt/openssl; and fish_add_path /opt/homebrew/opt/openssl
test -d /opt/homebrew/opt/gmp; and fish_add_path /opt/homebrew/opt/gmp

source $HOME/.config/fish/fzf.fish
source $HOME/.config/fish/aliases.fish
source $HOME/.config/fish/functions.fish

# Starship reads config from $STARSHIP_CONFIG; keep the file under ~/.config/starship/
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"

if status is-interactive
  # load_env_vars ~/.env
  starship init fish | source
  # source /opt/homebrew/opt/asdf/libexec/asdf.fish
end

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
fish_add_path "$PNPM_HOME"

# bun
set -gx BUN_INSTALL "$HOME/.bun"
fish_add_path "$BUN_INSTALL/bin"

# Java for Expo dev — pick first JDK that exists
for jdk in /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home \
           /Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home
  if test -d $jdk
    set -gx JAVA_HOME $jdk
    break
  end
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
