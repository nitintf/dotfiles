# fzf defaults. The colours below were previously behind an `if $macOS_Theme`
# check, but that variable is never set anywhere — so neither branch ever ran
# and fzf fell back to its built-in colours. The dark (One Dark) palette is
# applied unconditionally now, matching the Ghostty/VS Code themes.

set -x FZF_DEFAULT_OPTS
set -a FZF_DEFAULT_OPTS --height=70%
set -a FZF_DEFAULT_OPTS --border
set -a FZF_DEFAULT_OPTS --history=$HOME/.fzf_history
set -a FZF_DEFAULT_OPTS --marker='✓'

set -a FZF_DEFAULT_OPTS --color bg:'#282c34',bg+:'#282c34',fg:'#abb2bf'
set -a FZF_DEFAULT_OPTS --color query:'#abb2bf',fg+:'#c678dd',hl:'#61afef',hl+:'#61afef'
set -a FZF_DEFAULT_OPTS --color preview-bg:'#282c34',preview-fg:'#abb2bf'
set -a FZF_DEFAULT_OPTS --color border:'#abb2bf',gutter:'#282c34',header:'#98c379'
set -a FZF_DEFAULT_OPTS --color info:'#98c379',marker:'#e06c7f',pointer:'#e5c07b'
set -a FZF_DEFAULT_OPTS --color prompt:'#c678dd',spinner:'#61afef',separator:'#abb2bf'
set -a FZF_DEFAULT_OPTS --color query:regular

# PatrickF1/fzf.fish — file-search options (see fish_plugins)
set -g fzf_fd_opts --hidden --no-ignore --exclude=.git --exclude=Library
