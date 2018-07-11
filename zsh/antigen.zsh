source "$HOME/antigen/antigen.zsh"

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
antigen theme bhilburn/powerlevel9k powerlevel9k

export NVM_LAZY_LOAD=true
antigen bundle lukechilds/zsh-nvm

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
    pass
    perms
    pip
    pylint
    python
    quote
    svn
    systemd
    terraform
    urltools
    vagrant
EOB
if command_exists thefuck; then
    antigen bundle thefuck
fi

antigen apply
