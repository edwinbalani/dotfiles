ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d $ZSH_CACHE_DIR/completions ]] || mkdir -p $ZSH_CACHE_DIR/completions
fpath=($ZSH_CACHE_DIR/completions $fpath)
autoload -Uz compinit && compinit

export NVM_LAZY_LOAD=true
export ASDF_DIR="$HOME/.local/utilities/asdf"

source "$HOME/.antidote/antidote.zsh"
antidote load

autoload -Uz promptinit && promptinit && prompt powerlevel10k
