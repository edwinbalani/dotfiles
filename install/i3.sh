if command_exists i3; then
    mkdir -p "$HOME/.config/i3"
    "$LINK_CMD" "$DOTFILES_DIR/i3/config" "$HOME/.config/i3/config"
fi
