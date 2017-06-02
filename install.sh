#!/usr/bin/env bash

# Exit on error
set -e

# A reliable way of getting the current directory name
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# First, update the dotfiles themselves (if they were git cloned in the first place)
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

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

# Only install vim stuff if vim is installed
if ( hash vim 2>/dev/null )
then
    # Make necessary (sub)directories
    mkdir -p $HOME/.vim/colors
    mkdir -p $HOME/.vim/tmp/{backup,swap}

    # Link config and colour theme
    $LINK_CMD "$DOTFILES_DIR/.vimrc" "$HOME"
    if ( hash gvim 2>/dev/null )
    then
        $LINK_CMD "$DOTFILES_DIR/.gvimrc" "$HOME"
        $LINK_CMD "$DOTFILES_DIR/darktooth.vim" "$HOME/.vim/colors/"
    fi

    # Install Vundle if not already installed
    if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]
    then
        git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
    fi
    # Download plugins with Vundle
    vim +PluginUpdate +qall
fi

# Other config files
for f in .gitconfig;
do
    $LINK_CMD $DOTFILES_DIR/$f $HOME/$f
done
