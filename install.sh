#!/bin/bash

echo "edwinbalani's dotfiles/install.sh starting up..."
# Exit on error
set -e

# A reliable way of getting the current directory name
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# First, update the dotfiles themselves (if they were git cloned in the first place)
echo "Updating dotfiles..."
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# If zsh is an available shell, get Oh My Zsh (which will automatically chsh to zsh)
if hash zsh 2>/dev/null && grep -Fxq "$(which zsh)" /etc/shells
then
    echo "Found zsh! Installing oh-my-zsh..."
    if hash curl; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    elif hash wget; then
        sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    else
        echo "WARNING: Oh My Zsh installation could not complete because neither curl nor wget were found on this system."
    fi
fi

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
    echo "Vim is installed - installing .vimrc and plugins..."
    # Make necessary (sub)directories
    mkdir -p "$HOME/.vim/colors"
    mkdir -p "$HOME/.vim/tmp/{backup,swap}"

    # Link config and colour theme
    $LINK_CMD "$DOTFILES_DIR/.vimrc" "$HOME"
    if ( hash gvim 2>/dev/null )
    then
        echo "(GVim also detected) - also installing colour scheme and .gvimrc"
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

# git-fire
if ! ( hash git-fire 2>/dev/null ); then
    echo "Installing git-fire..."
    git_fire_url="https://raw.githubusercontent.com/edwinbalani/git-fire/master/git-fire"
    git_fire_dest="$HOME/.local/bin"
    git_fire_path="$git_fire_dest/git-fire"
    mkdir -p "$git_fire_dest"
    if hash curl 2>/dev/null; then
        curl -o "$git_fire_path" "$git_fire_url"
    elif hash wget 2>/dev/null; then
        wget -O "$git_fire_path" "$git_fire_url"
    else
        echo "Couldn't find curl or wget to download git-fire."
        echo "Download manually to $git_fire_dest/git-fire from this URL:"
        echo "$git_fire_url"
        exit 1
    fi && chmod +x "$git_fire_path" && echo "Now you can use 'git fire', 'git out' or 'git going' in an emergency! Make sure $git_fire_dest is in your \$PATH"
else
    echo "git-fire already found on your system; not installing again"
fi

# Other config files
for f in .gitconfig .tmux.conf .gitignore;
do
    $LINK_CMD "$DOTFILES_DIR/$f" "$HOME/$f"
done
