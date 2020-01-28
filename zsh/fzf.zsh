if command_exists fzf; then
    inc_path=/usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f "$inc_path" ] && . "$inc_path"
fi
