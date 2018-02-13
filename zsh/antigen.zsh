source "$HOME/antigen/antigen.zsh"

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
antigen theme bhilburn/powerlevel9k powerlevel9k

antigen use oh-my-zsh

antigen bundles <<EOB
    aws
    command-not-found
    common-aliases
    django
    docker
    encode64
    git
    git-extras
    history
    httpie
    jsontools
    perms
    pip
    pylint
    python
    quote
    systemd
    terraform
    urltools
    vagrant
EOB
if command -v thefuck >/dev/null 2>&1; then
    antigen bundle thefuck
fi

antigen apply
