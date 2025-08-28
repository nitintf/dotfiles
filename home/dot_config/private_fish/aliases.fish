# Docker
alias dl='docker ps'
alias dc='docker-compose'
alias dv='docker volume ls'
alias dce='docker-compose exec'
alias dcs='docker-compose stop'
alias dcd='docker-compose down'
alias dcb='docker-compose build'
alias dcu='docker-compose up -d'
alias dlog='docker-compose logs -f'
alias dx='docker system prune -a -f'
alias dub='docker-compose up -d --build'
alias dclear='docker rm -fv $(docker ps -aq)'
alias dcud='docker-compose -f docker-compose.dev.yml up -d'
alias dcsd='docker-compose -f docker-compose.dev.yml stop'
alias dcup='docker-compose -f docker-compose.prod.yml up -d'
alias dcsp='docker-compose -f docker-compose.prod.yml stop'

# Fish
alias fi='fisher install'
alias fl='fisher list'
alias fu='fisher update'
alias fr='fisher remove'

# Git
alias lg='lazygit'
alias ga='git add'
alias gp='git pull'
alias gpp='git push'
alias gaa='git add .'
alias gst='git status'
alias gc='git commit -m'
alias gnb='git checkout -b'
alias gb='git checkout'
alias gpu='git push origin master'
alias pr='git push --set-upstream origin'
alias gcu='git reset --soft HEAD^'

# Homebrew
alias br='brew remove'
alias bu='brew update'
alias bs='brew search'
alias bi='brew install'
alias bupg='brew upgrade && brew cleanup'

# Misc
alias l='lsd -F --group-directories-first'
alias ll='lsd --long'
alias ls='lsd'
alias la='lsd -a'
alias lla='lsd -la'
alias essh='nvim ~/.ssh/config'
alias chmodall='sudo chmod -R 0777'
alias copyssh='pbcopy < ~/.ssh/$1'

# Neovim / Vim
alias v='nvim'
alias vi='nvim'
alias vim='/opt/homebrew/bin/vim'

# Python
alias jup='jupyter notebook'
alias pipb='pip freeze > ~/.dotfiles/PIP.txt'
alias pipi='pip install -r ~/.dotfiles/PIP.txt'
alias jupr="jupyter notebook --NotebookApp.allow_origin='https://colab.research.google.com' --port=9090 --no-browser"

# Shell
alias c='clear'
alias ea='nvim ~/.config/fish/aliases.fish'
alias et='nvim ~/.config/tmux/tmux.conf'
alias src='source ~/.config/fish/config.fish && fish_logo'

# Shell navigation
alias ..='cd ..'
alias bk='cd -'
alias home='cd ~'
alias ...='cd ../..'
alias desk='cd ~/Desktop'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Tmux
alias tsa='tmux-sendall'                # Send a command to all windows and panes that don't have a process running
alias tks='tmux kill-server'            # Kill everything
alias tl='tmux list-sessions'           # List all of the open tmux sessions
alias ts='tmux choose-session'          # Choose a session to attach to
alias tk='tmux kill-session -t'         # Kill a named tmux session
alias td='tmux detach'                  # Detach current session
alias ta='tmux attach -t'               # Attach to named tmux session
alias t='tmux attach || tmux new-session'   # Attaches tmux to the last session; creates a new session if none exists.
alias tpi='~/.config/tmux/plugins/tpm/bin/install_plugins' # Installs Tmux plugins
alias tpu='~/.config/tmux/plugins/tpm/bin/update_plugins all' # Updates all Tmux plugins

# nvm
alias nu='nvm use'
