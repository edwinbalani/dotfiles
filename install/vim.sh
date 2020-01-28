# Only install vim stuff if vim is installed
if command_exists vim; then
    echo "Vim is installed - installing .vimrc and plugins..."
    # Make necessary (sub)directories
    mkdir -p "$HOME/.vim/colors"
    mkdir -p "$HOME/.vim/tmp/backup" "$HOME/.vim/tmp/swap"

    # Link config and colour theme
    $LINK_CMD "$DOTFILES_DIR/vim/.vimrc" "$HOME"
    if command_exists gvim; then
        echo "GVim also detected - installing colour scheme and .gvimrc"
        $LINK_CMD "$DOTFILES_DIR/vim/.gvimrc" "$HOME"
        $LINK_CMD "$DOTFILES_DIR/vim/darktooth.vim" "$HOME/.vim/colors/"
    fi

    # Install vim-plug if not already installed
    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]
    then
        curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
            "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    fi
    # Download plugins with Vundle
    vim +PlugUpdate +PlugClean! +qall
else
    echo "Couldn't find vim - not installing .vimrc and plugins"
fi
