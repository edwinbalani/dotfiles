########## PATH and exports

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.local/share/man" ]; then
    export MANPATH="$HOME/.local/share/man:$MANPATH"
fi

if [ -d /usr/local/go/bin ]; then
    export PATH="$PATH:/usr/local/go/bin"
fi

if command -v go >/dev/null 2>&1 && [ -d "$HOME/go" ]; then
    export GOPATH="$HOME/go"
    export PATH="$PATH:$GOPATH/bin"
fi

[ -d "$HOME/.local/utilities" ] && \
    find "$HOME/.local/utilities" -mindepth 1 -maxdepth 1 -type d | \
    while read plugin_path; do
        export PATH="$PATH:$plugin_path"
    done

export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"