########## PATH and exports
if command_exists vim; then
    export EDITOR=vim
    export VISUAL=vim
elif command_exists vi; then
    export EDITOR=vi
    export VISUAL=vi
elif command_exists nano; then
    export EDITOR=nano
    export VISUAL=nano
elif command_exists pico; then
    export EDITOR=pico
    export VISUAL=pico
fi


if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.local/share/man" ]; then
    export MANPATH=":$HOME/.local/share/man:$MANPATH"
fi

if [ -d /usr/local/go/bin ]; then
    export PATH="$PATH:/usr/local/go/bin"
fi

if command_exists go && [ -d "$HOME/go" ]; then
    export GOPATH="$HOME/go"
    export PATH="$PATH:$GOPATH/bin"
fi

[ -d "$HOME/.local/utilities" ] && \
    find "$HOME/.local/utilities" -mindepth 1 -maxdepth 1 -type d | \
    while read -r plugin_path; do
        if [ -d "$plugin_path/bin" ]; then
            export PATH="$PATH:$plugin_path/bin"
        else
            export PATH="$PATH:$plugin_path"
        fi
    done

export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"

if ! (echo "$LESS" | grep -Fq -- '-R'); then export LESS="$LESS -R"; fi
if ! (echo "$LESS" | grep -Fq -- '-MM'); then export LESS="$LESS -MM"; fi

if command_exists lesspipe; then
    # shellcheck disable=SC2046
    eval $(lesspipe)
elif command_exists lessfile; then
    # shellcheck disable=SC2046
    eval $(lessfile)
fi
