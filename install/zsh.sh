# If zsh is an available shell, get antigen
if command -v zsh >/dev/null 2>&1 && grep -Fxq "$(which zsh)" /etc/shells
then
    echo "Found zsh! Installing antigen..."
    if [ -e "$HOME/antigen" ]; then
        echo "ERROR: $HOME/antigen (the installation location for antigen) already exists."
        echo "       Please move this out of the way before proceeding."
    elif command -v git >/dev/null 2>&1; then
        git clone --depth=1 https://github.com/zsh-users/antigen.git "$HOME/antigen"
    else
        echo "ERROR: antigen installation could not complete because git isn't installed on this system."
    fi
    $LINK_CMD "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
fi
