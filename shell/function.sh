########## functions

sdas () {
    # Credit to mas90
    user="$1"
    shift
    sudo -u "$user" XDG_RUNTIME_DIR="/run/user/$(id -u "$user")" "$@"
}

# Update dotfiles on remote systems (how ~meta~ is that?)
update-dotfiles () {
    for host in "${@}"; do
        ssh "$host" '. ~/.dotfiles-location && cd $DOTFILES_DIR && git pull' \
            || echo "=== Update for $host failed ==="
    done
}

# tmux:
if command_exists tmux 2>&1; then
    # - create a new session, or join an existing one if it exists
    att () {
        if tmux has -t "$1" 2>/dev/null; then
            # If a session exists...
            if [ "$(tmux ls -F '#{session_name}:#{session_attached}' | awk -F: "/^$1:/ {print \$2}")" = "0" ]; then
                # ...if it's detached, attach to it
                tmux attach -t "$1"
            else
                # ...otherwise, spawn a temporary session to join its group,
                # which is deleted at the end to avoid polluting with sessions
                temp_session_name="$(tmux new-session -t "$1" -d -P -F "#{session_name}")"
                tmux attach -t "$temp_session_name"
                tmux kill-session -t "$temp_session_name"
            fi
        else
            # and if a session doesn't exist, just create it
            if [ -n "$1" ]; then
                tmux new-session -s "$1"
            else
                tmux new-session
            fi
        fi
    }

    # - list sessions
    # this should really be in alias.sh, but I wanted to keep these
    # two commands together
    alias tls="tmux ls"
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
  cd "$mntpoint" || true
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

if command_exists mise; then
    quikasdf () {
        if [ -z "$1" ]; then
            mise registry
        else
            mise use --global "$@"
        fi
    }
else
    quikasdf () {
        local tool="$1"
        if [ -z "$1" ]; then
            asdf plugin list-all
        else
            local version="${2:-latest}"
            asdf plugin add "$tool" && asdf install "$tool" "$version" && asdf global "$tool" "$version"
        fi
    }
fi
