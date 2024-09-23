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

install_plugin asdf "https://github.com/asdf-vm/asdf.git"
if [ ! -e "$HOME/.asdf" ]; then
    $LINK_CMD "$HOME/.local/utilities/asdf" "$HOME/.asdf"
fi

# TODO asdf plugin for gibo
#install_plugin gibo "https://github.com/simonwhitaker/gibo.git"

if command_exists zathura && command_exists pandoc && (command_exists vim || command_exists nvim); then
    install_plugin notes "https://github.com/edwinbalani/notes.git"
fi
