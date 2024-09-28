# If zsh is an available shell, get antidote for plugin management
if is_shell zsh; then
    if [ ! -d "$HOME/.antidote" ]; then
        echo "Installing antidote..."
        git clone --depth=1  https://github.com/mattmc3/antidote.git "$HOME/.antidote"
    fi
    $LINK_CMD "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
    $LINK_CMD "$DOTFILES_DIR/zsh/zsh_plugins.txt" "$HOME/.zsh_plugins.txt"
fi

# Directory for random local fpath additions
mkdir -p "$HOME/.zfunc"
