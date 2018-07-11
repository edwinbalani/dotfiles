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

    # Install Vundle if not already installed
    if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]
    then
        git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
    fi
    # Download plugins with Vundle
    vim +PluginUpdate +PluginClean! +qall
else
    echo "Couldn't find vim - not installing .vimrc and plugins"
fi
