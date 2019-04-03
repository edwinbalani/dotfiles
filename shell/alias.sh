########## aliases

# did file -- https://theptrk.com/2018/07/11/did-txt-file/
alias did="vim +'normal Go' +'r!date' ~/did.txt"

# iproute2, pretty colours
(ip -color addr >/dev/null 2>&1) && alias ip="ip -color"
(ip -brief addr >/dev/null 2>&1) && alias ipb="ip -brief"
(ip -s -h  addr >/dev/null 2>&1) && alias ipst="ip -stat -human-readable"

# RSI avoidance measures
if command_exists vim && (vim --version | grep -Fq -- '+clientserver'); then
    alias vim="vim --servername vim"
fi

# terraform is too long to type :P
if command_exists terraform; then
    alias tf=terraform
fi

# Nice git commands
if command_exists git; then
    alias lg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
    alias lga="lg --all"
fi

# purdy quotes
if command_exists fortune && command_exists cowsay; then
    alias forsay="fortune | cowsay -n -W 80"
    alias clear="command clear ; forsay"
    # Only do `forsay` if it's an interactive shell
    # (can break programs like rsync otherwise)
    case $- in
        *i*) fortune | cowsay -n -W 80;;
    esac
fi

if command_exists python || command_exists python3; then
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
if command_exists hub; then
    alias git=hub
fi

# https://termbin.com
if command_exists nc; then
    alias tb="nc termbin.com 9999"
fi
