########## functions

# Update dotfiles on remote systems (how ~meta~ is that?)
update-dotfiles () {
    for host in "${@}"; do
        ssh "$host" '. ~/.dotfiles-location && cd $DOTFILES_DIR && git pull'
    done
}

# tmux:
if command -v tmux >/dev/null 2>&1; then
    # - create a new session, or join an existing one if it exists
    att () {
        if tmux has -t "$1" 2>/dev/null; then
            tmux new-session -t "$1"
        else
            tmux new-session -As "$1"
        fi
    }

    # - list sessions
    # this should really be in alias.sh, but I wanted to keep these
    # two commands together
    alias tls="tmux ls"
fi

# thefuck (if it's installed)
if command -v thefuck >/dev/null 2>&1; then
    eval "$(thefuck --alias)"
fi

# Mount and unmount SSHFS
mnt () {
  host=$1
  folder=$2
  shift 2
  mntpoint=$HOME/remote/$host
  umnt "$host"
  mkdir -p "$mntpoint"
  sshfs "$host:$folder" "${@}" "$mntpoint"
  cd "$mntpoint"
}

umnt () {
  host=$1
  shift
  mntpoint=$HOME/remote/$host
  if mountpoint -q -- "$mntpoint"
  then
    fusermount -u "$mntpoint" && rmdir "$mntpoint"
  fi
}

# PDF tools
panpdf () {
    pandoc -o "$(basename -s.md "$1").pdf" -Vpapersize:a4 -Vgeometry:'margin=1.1in' -Vmainfontoptions:'Scale=1.1' "$1"
}

pdf_bw () {
    gs \
    -sOutputFile=output.pdf \
    -sDEVICE=pdfwrite \
    -sColorConversionStrategy=Gray \
    -dProcessColorModel=/DeviceGray \
    -dCompatibilityLevel=1.4 \
    -dNOPAUSE \
    -dBATCH \
    "$1"
}
