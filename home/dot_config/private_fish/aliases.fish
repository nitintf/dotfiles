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

# Chezmoi
alias ch='chezmoi'
alias cha='chezmoi add'
alias chd='chezmoi diff'
alias chs='chezmoi status'

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
alias pr='git push --set-upstream origin'
alias gcu='git reset --soft HEAD^'

# Git worktrees (gwl, gwa, gwr, gwcd are functions in functions.fish)
alias gw='git worktree'
alias gwp='git worktree prune'
alias gwls='git worktree list'

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
alias ai='claude'

# Neovim / Vim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Python
alias jup='jupyter notebook'
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
alias tks='tmux kill-server'            # Kill everything
alias tl='tmux list-sessions'           # List all of the open tmux sessions
alias ts='tmux choose-session'          # Choose a session to attach to
alias tk='tmux kill-session -t'         # Kill a named tmux session
alias td='tmux detach'                  # Detach current session
alias t='tmux attach || tmux new-session'   # Attaches tmux to the last session; creates a new session if none exists.
alias tpi='~/.config/tmux/plugins/tpm/bin/install_plugins' # Installs Tmux plugins
alias tpu='~/.config/tmux/plugins/tpm/bin/update_plugins all' # Updates all Tmux plugins

# mise (replaces nvm/asdf/rbenv — one manager for every runtime)
alias mi='mise install'                 # install what this project pins
alias mu='mise use'                     # pin for this project: mu node@20
alias mug='mise use -g'                 # pin globally:        mug node@lts
alias ml='mise ls'                      # what's installed / active here
alias mlr='mise ls-remote'              # versions available to install
alias mo='mise outdated'
alias mx='mise exec --'                 # run once without pinning: mx node@18 -- node -v
alias mt='mise tasks'

# Git delta — `git diff` is already piped through delta via ~/.gitconfig.
alias dlt='delta --side-by-side'        # eyeball two files: dlt a.txt b.txt
alias gd='git diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'

# atuin (ctrl-r opens the history search; these are the out-of-band bits)
alias hs='atuin search'
alias hst='atuin stats'
alias hsync='atuin sync'

# just
alias j='just'
alias jl='just --list'
alias jc='just --choose'                # fzf-style picker over recipes

# uv (python packaging)
alias uvs='uv sync'
alias uvr='uv run'
alias uva='uv add'
alias uvv='uv venv'

# terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfv='terraform validate'
alias tff='terraform fmt -recursive'
