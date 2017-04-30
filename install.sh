#!/usr/bin/env bash

export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

# Don't bother with vim stuff if it isn't installed
if ( hash vim 2>/dev/null )
then
    $LINK_CMD "$DOTFILES_DIR/.vimrc" ~
    if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]
    then
        git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    fi
    vim +BundleInstall +qall
fi

# Other config files
for f in .gitconfig;
do
    $LINK_CMD $DOTFILES_DIR/$f $HOME/$f
done
