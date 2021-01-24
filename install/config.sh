# Other config files
for f in gitconfig tmux.conf gitignore condarc latexmkrc lftprc
do
    $LINK_CMD "$DOTFILES_DIR/config/$f" "$HOME/.$f"
done
