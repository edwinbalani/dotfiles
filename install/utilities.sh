# A generic function for installing utilities that place executable script(s)
# in the root of their Git repository
install_plugin() {
    dest_dir="$HOME/.local/utilities/$1"
    if [ -d "$dest_dir" ]; then
        if [ -d "$dest_dir/.git" ]; then
            echo "Already found $1 - updating..."
            git --work-tree="$dest_dir" --git-dir="$dest_dir/.git" pull origin master
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
install_plugin gibo "https://github.com/simonwhitaker/gibo.git"
install_plugin git-fire "https://github.com/edwinbalani/git-fire.git"
if command_exists zathura && command_exists pandoc && (command_exists vim || command_exists nvim); then
    install_plugin notes "https://github.com/edwinbalani/notes.git"
fi
