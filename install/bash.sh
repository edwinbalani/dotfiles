# If bash is an available shell, install a couple of basic things
# Not much here, since I tend to use zsh
# We don't overwrite the existing bashrc, since there's often some stuff there already
bash_source_line="source $DOTFILES_DIR/bash/bashrc"
if is_shell bash && ! grep -q "^$bash_source_line$" "$HOME/.bashrc"; then
    echo "Hooking our bashrc into ~/.bashrc..."
    echo "$bash_source_line" >> "$HOME/.bashrc"
fi
