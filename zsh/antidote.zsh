ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d $ZSH_CACHE_DIR/completions ]] || mkdir -p $ZSH_CACHE_DIR/completions
fpath=($ZSH_CACHE_DIR/completions $fpath $HOME/.zfunc)
autoload -Uz compinit && compinit

export NVM_LAZY_LOAD=true

[[ -x "$HOME/.local/bin/mise" ]] && eval "$("$HOME/.local/bin/mise" activate zsh)"
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

export FZF_CTRL_T_COMMAND="fd --type file --hidden --exclude .git --color=always"
export FZF_DEFAULT_OPTS="--ansi"

if ! command_exists fzf; then
    FZF_BASE="$(mise where fzf)"
fi

source "$HOME/.antidote/antidote.zsh"
antidote load

unalias gg  # collision with grip-grab

autoload -Uz promptinit && promptinit && prompt powerlevel10k
