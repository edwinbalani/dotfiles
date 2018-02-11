source "$HOME/antigen/antigen.zsh"

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
antigen theme bhilburn/powerlevel9k powerlevel9k

antigen use oh-my-zsh

antigen bundle aws
antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle docker
antigen bundle django
antigen bundle encode64
antigen bundle git
antigen bundle git-extras
antigen bundle history
antigen bundle httpie
antigen bundle jsontools
antigen bundle last-working-dir
antigen bundle perms
antigen bundle pip
antigen bundle pylint
antigen bundle python
antigen bundle quote
antigen bundle systemd
antigen bundle terraform
if command -v thefuck >/dev/null 2>&1; then
    antigen bundle thefuck
fi
antigen bundle urltools
antigen bundle vagrant

antigen apply
