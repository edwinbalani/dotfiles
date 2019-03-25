# Other config files
for f in gitconfig tmux.conf gitignore latexmkrc;
do
    $LINK_CMD "$DOTFILES_DIR/config/$f" "$HOME/.$f"
done
