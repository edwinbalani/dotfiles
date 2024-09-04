autoload zmv

# opam configuration
test -r "$HOME/.opam/opam-init/init.zsh" && . "$HOME/.opam/opam-init/init.zsh" >/dev/null 2>/dev/null

# Workaround for https://github.com/nvm-sh/nvm/issues/3007
# suggested in https://github.com/nvm-sh/nvm/issues/3007#issuecomment-1405002512
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"

typeset -g HYPHEN_INSENSITIVE="true"
typeset -g COMPLETION_WAITING_DOTS="true"
typeset -g HIST_STAMPS="yyyy-mm-dd"
