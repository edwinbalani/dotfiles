########## functions

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
  umnt $host
  mkdir -p $mntpoint
  sshfs $host:$folder $@ $mntpoint
  cd $mntpoint
}

umnt () {
  host=$1
  shift
  mntpoint=$HOME/remote/$host
  if mountpoint -q -- $mntpoint
  then
    fusermount -u $mntpoint && rmdir $mntpoint
  fi
}

# PDF tools
panpdf () {
    pandoc -o $(basename -s.md "$1").pdf -Vpapersize:a4 -Vgeometry:'margin=1.1in' -Vmainfontoptions:'Scale=1.1' "$1"
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
    $1
}
