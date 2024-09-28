autoload zmv

# opam configuration
test -r "$HOME/.opam/opam-init/init.zsh" && . "$HOME/.opam/opam-init/init.zsh" >/dev/null 2>/dev/null

export NVM_DIR="$HOME/.nvm"
if [[ -e "$HOME/.nvm" ]]; then
    # https://github.com/nvm-sh/nvm/issues/2362#issuecomment-746108881
    setopt no_aliases
    export NVM_DIR="$HOME/.nvm"
    . "$NVM_DIR/nvm.sh"
    setopt aliases
fi

typeset -g HYPHEN_INSENSITIVE="true"
typeset -g COMPLETION_WAITING_DOTS="true"
typeset -g HIST_STAMPS="yyyy-mm-dd"
