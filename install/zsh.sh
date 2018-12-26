# If zsh is an available shell, get antigen
if is_shell zsh; then
    if [ -d "$HOME/antigen" ]; then
        echo "Found a directory at ~/antigen"
        if command_exists antigen; then
            echo " -- assuming it's antigen.zsh and updating..."
            antigen selfupdate
            antigen update
        else
            echo " -- couldn't find the 'antigen' command to update!  Continuing..."
        fi
    elif command_exists git; then
        echo "Found zsh! Installing antigen..."
        git clone --depth=1 https://github.com/zsh-users/antigen.git "$HOME/antigen"
    else
        echo "ERROR: antigen installation could not complete because git isn't installed on this system."
    fi
    $LINK_CMD "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
fi
