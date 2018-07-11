# If zsh is an available shell, get antigen
if is_shell zsh; then
    if [ -d "$HOME/antigen/.git" ]; then
        echo "Found a git repo at ~/antigen -- assuming it's antigen.zsh and updating..."
        git --work-tree="$HOME/antigen" --git-dir="$HOME/antigen/.git" pull origin master
    elif [ -e "$HOME/antigen" ]; then
        echo "ERROR: $HOME/antigen (the installation location for antigen) already exists."
        echo "       Please move this out of the way before proceeding."
    elif command -v git >/dev/null 2>&1; then
        echo "Found zsh! Installing antigen..."
        git clone --depth=1 https://github.com/zsh-users/antigen.git "$HOME/antigen"
    else
        echo "ERROR: antigen installation could not complete because git isn't installed on this system."
    fi
    $LINK_CMD "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
fi
