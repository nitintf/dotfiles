#!/usr/bin/env bash

source ./scripts/utils.sh

cd "$(dirname "$0")/.."
DOTFILES=$(pwd -P)

set -e

echo ''

install_dotfiles () {
  info 'installing dotfiles\n'

  local overwrite_all=false backup_all=false skip_all=false

  find -H "$DOTFILES" -maxdepth 2 -name 'links.prop' -not -path '*.git*' | while read linkfile
  do
    cat "$linkfile" | tr -d '\r' | while read line
    do
        local src dst dir
        src=$(eval echo "$line" | cut -d '=' -f 1)
        dst=$(eval echo "$line" | cut -d '=' -f 2)
        dir=$(dirname $dst)

        mkdir -p "$dir"
        link_file "$src" "$dst"
    done
  done
}

install_dotfiles

echo ''

success 'Successfully Installed!'
