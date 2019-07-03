if command_exists alacritty; then
    mkdir -p "$HOME/.config/alacritty"
    "$LINK_CMD" "$DOTFILES_DIR/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
fi
