########## aliases

# RSI avoidance measures
export EDITOR=vim
export VISUAL=vim
if command -v vim >/dev/null 2>&1 && (vim --version | grep -Fq -- '+clientserver'); then
    alias vim="vim --servername vim"
fi

# tmux
if command -v tmux >/dev/null 2>&1; then
    alias att="tmux new -As"
    alias tls="tmux ls"
fi

# terraform is too long to type :P
alias tf=terraform

# Nice git commands
if command -v git >/dev/null 2>&1; then
    alias lg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
    alias lga="lg --all"
fi

# purdy quotes
if command -v fortune >/dev/null 2>&1 && command -v cowsay >/dev/null 2>&1; then
    alias forsay="fortune | cowsay -n -W 80"
    alias clear="command clear ; forsay"
    fortune | cowsay -n -W 80
fi

if command -v python >/dev/null 2>&1 || command -v python3 >/dev/null 2>&1; then
    # Django
    alias dj="python manage.py runserver"
    alias ma="python manage.py"

    # ptpython
    alias ptpython="ptpython --vi"
    alias ptipython="ptipython --vi"

    # Jupyter
    alias nb="python -m jupyter notebook"
    alias nb3="python3 -m jupyter notebook"
fi

# Here be dragons (not really: https://github.com/github/hub)
if command -v hub >/dev/null 2>&1; then
    alias git=hub
fi
