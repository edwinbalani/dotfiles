# A generic function for installing utilities that place executable script(s)
# in the root of their Git repository or under a bin/ subdirectory
install_plugin() {
    dest_dir="$HOME/.local/utilities/$1"
    if [ -d "$dest_dir" ]; then
        if [ -d "$dest_dir/.git" ]; then
            echo "Already found $1 - updating..."
            git -C "$dest_dir" pull origin
        else
            echo "WARNING: Already found $1 in $dest_dir - can't update (didn't detect a git repo)"
        fi
    else
        echo "Installing $1..."
        mkdir -p "$dest_dir"
        git clone --depth=1 "$2" "$dest_dir"
    fi
}

# Install mise(-en-place), a dev environment tool
# https://mise.jdx.dev/
"$DOTFILES_DIR/vendor/mise-install.sh"

# for the purposes of this install script, get a direct path to the mise binary
# rather than fiddling with PATH or running 'mise activate'
export PATH="${MISE_INSTALL_PATH:-$HOME/.local/bin}:$PATH"

# Install ubi, the "Universal Binary Installer"
# https://github.com/houseabsolute/ubi
TARGET="$HOME/.local/bin" "$DOTFILES_DIR/vendor/bootstrap-ubi.sh"

# This may result in double-entry of ~/.local/bin to PATH, if an override of
# $MISE_INSTALL_PATH was not supplied.  That's fine.
export PATH="$HOME/.local/bin:$PATH"

mise settings set experimental true  # required for ubi use
mise use --global ubi:simonwhitaker/gibo
mise use --global ubi:arxanas/git-branchless
mise use --global fd
mise use --global fzf

if command_exists zathura && command_exists pandoc && (command_exists vim || command_exists nvim); then
    install_plugin notes "https://github.com/edwinbalani/notes.git"
fi

install_plugin git-hires-merge "https://github.com/paulaltin/git-hires-merge.git"
