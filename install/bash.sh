# If bash is an available shell, install a couple of basic things
# Not much here, since I tend to use zsh
if command -v bash >/dev/null 2>&1 && grep -Fxq "$(which bash)" /etc/shells
then
    echo "Found bash! Injecting a simple bashrc hook..."
    # We don't overwrite the existing bashrc, since there's often some stuff there already
    echo "source $DOTFILES_DIR/bash/bashrc" >> "$HOME/.bashrc"
fi
