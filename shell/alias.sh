########## aliases

alias fixkeys="setxkbmap -layout gb; xmodmap -e 'clear lock' -e 'keysym Caps_Lock = Escape'; xset r rate 300 35"
alias FIXKEYS=fixkeys

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

# Use Knot dnsutils if needs be
for cmd in dig nsupdate; do
    if command_exists k$cmd && ! command_exists $cmd; then
        # shellcheck disable=SC2139
        alias $cmd=k$cmd
    fi
done

# terraform is too long to type :P
if command_exists terraform; then
    alias tf=terraform
fi

# Nice git commands
if command_exists git; then
    alias lg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
    alias lga="lg --all"
    # next three inspired by https://utcc.utoronto.ca/~cks/space/blog/programming/GitAliasesIUse
    # see also .gitconfig
    alias gsrc="git remote get-url origin"
    alias glff="git pull --ff-only"
    alias gmff="git merge --ff-only"
fi

# purdy quotes
if command_exists fortune && command_exists cowsay; then
    forsay () {
        fortune "$@" | cowsay -n -W 80
    }
    alias clear="command clear ; forsay"
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

# https://termbin.com
if command_exists nc; then
    alias tb="nc termbin.com 9999"
fi
