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
set -x GOPATH $HOME/go
set -x PATH /usr/local/go/bin $GOPATH/bin $PATH
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

# Paths
fish_add_path /opt/homebrew/bin/brew
fish_add_path /opt/homebrew/sbin
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.dotfiles/bin"
fish_add_path "$HOME/.local/share/nvim/mason/bin"
fish_add_path "/opt/homebrew/opt/openssl"
fish_add_path "/opt/homebrew/opt/gmp"

source $HOME/.config/fish/fzf.fish
source $HOME/.config/fish/aliases.fish
source $HOME/.config/fish/functions.fish

if status is-interactive
  # load_env_vars ~/.env
  starship init fish | source
  # source /opt/homebrew/opt/asdf/libexec/asdf.fish
end

# pnpm
set -gx PNPM_HOME "/Users/nitinpanwar/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
