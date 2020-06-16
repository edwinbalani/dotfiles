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
if command_exists zathura && command_exists pandoc && command_exists vim; then
    install_plugin notes "https://github.com/edwinbalani/notes.git"
fi

# Install thefuck only if we have Python 3; its support for Python 2 is deprecated
for py in python3 python; do
    if [ "$($py -c 'from __future__ import print_function; import sys; print(sys.version[0])')" -ge 3 ]; then
        printf "import sys\ntry:\n import pip\nexcept ImportError:\n sys.exit(1)\nelse:\n sys.exit(0)" | \
            $py >/dev/null 2>&1 && \
            $py -m pip install --user thefuck
        break
    fi
done
