#!/bin/bash

echo "edwinbalani's dotfiles/install.sh starting up..."

# A reliable way of getting the current directory name
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DOTFILES_DIR

printf "export DOTFILES_DIR=%s\n" "$DOTFILES_DIR" > "$HOME/.dotfiles-location"

# Arguments for ln
# from https://github.com/bndabbs/dotfiles/blob/master/setup.sh
params="-sf"
while getopts "vib" args; do
    case $args in
        v)
            params="$params -v"
            ;;
        i)
            params="$params -i"
            ;;
        b)
            params="$params -b"
            ;;
    esac
done
LINK_CMD="ln $params"

# First, update the dotfiles themselves (if they were git cloned in the first place)

if [ -d "$DOTFILES_DIR/.git" ]; then
    echo "Updating dotfiles..."
    pushd "$DOTFILES_DIR"
    current_head=$(git rev-parse HEAD)
    git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master
    if [ "$(git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" log --stat "$current_head.." -- install/ install.sh | wc -l)" -ne 0 ]; then
        echo "WARNING: the installation scripts were updated by 'git pull'."
        echo "         Please re-run this file ($0) to continue installation."
        exit 1
    fi
    popd
fi

for component in $DOTFILES_DIR/install/*.sh; do
    source "$component"
done
