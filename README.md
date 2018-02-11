# edwinbalani's dotfiles

---

Congratulations if you've found these.  Note that they're mainly for my own use,
and thus may have some opinionated personalisations that I find useful.

## Contents

1. [Introduction](#introduction)
2. [Recommended programs](#recommended-programs)
3. [Installation](#installation)
    1. [Requirements](#requirements)
    2. [One line to install](#one-line-to-install)
4. [Technical information](#technical-information)
    1. [Directory structure](#directory-structure)
    2. [Rationale](#rationale)
    3. [How it works](#how-it-works)

---

## Introduction

- You may use these dotfiles as-is, if you want to.  They come with **no
  warranty or guarantee of quality**.  (If your computer catches fire, becomes
  sentient or otherwise ruins your life as a result of using these dotfiles,
  then it's not my fault, because I just said so.  Do let me know if that
  happens though, because if my measly dotfiles caused that to happen then it
  would be _really cool_.)

- However, **you may not share, distribute, publish or transmit the contents of
  this repository, or derivative works (_i.e._ modified/customised versions of
  these dotfiles)**.  If you want to recommend them to a friend, please share
  the URL for this repository.  Just because these dotfiles are public on
  GitHub, it doesn't mean that they're free software.

  In other words: **All rights reserved.  Copyright (C) 2017-18 Edwin Balani.**

- If you want to make use of some or all of these dotfiles as part of your own,
  then **please email me** at the address listed on [my GitHub
  profile](https://github.com/edwinbalani).

Why the last two bullet points? Because:

1. If other people want to use my dotfiles, then I want to know, so that I can
   make more of an effort to maintain them properly, improve them and clean them
   up where necessary.

2. Also: if there is actual interest in my dotfiles (_very unlikely_) then
   I will be very keen to make them free software, and remove the restrictive
   copyright notice above, **but** only when they're to a high enough standard
   to be released into the wild.

---

## Recommended programs

To make the most of these dotfiles, it is _highly recommended_ that you
install these programs:

- `zsh`
- `vim` (and optionally `gvim` if you're in a graphical environment)
- `tmux`

There are a few others that are more optional:

- `thefuck`
- `fortune` and `cowsay` (both together makes for a nice shell message ;) )
- [`hub`](https://github.com/github/hub)

_(If you're not a fan of these programs, you're probably in the wrong place.  As
I said at the top of this README, these dotfiles are mainly for my own use, so
I'm going to customise them for how *I* use my system.)_

---

## Installation

### Requirements

 - `git` to keep the repository updated
 - `bash` for the install script

### One line to install

```bash
$ git clone https://github.com/edwinbalani/dotfiles.git ~/dotfiles && ~/dotfiles/install.sh
```

---

## Technical information

_Read this section if you're interested in how these dotfiles install themselves
on your computer, or if you're thinking of hacking on them.  It's not mandatory,
though; you can just run `install.sh` and be happy._

### Directory structure

- `config/`: contains 'singleton' files to be symlinked directly into \$HOME
  (e.g. `.gitconfig`, `.tmux.conf`)

- `install/`: contains the installation scripts for the dotfiles.  They're
  broken up into multiple files, each of which serve to install a certain
  'component'.

  Many of the components are dependent on the installation of a particular
  program, e.g. `vim` or `zsh`.  The installation process automatically detects
  the presence of these, and skips installation of dependent components if they
  aren't present.

- `vim/`: contains dotfiles relevant to `vim`.  These are only installed if
  `vim` is detected.  If you have `gvim`, a couple of bonus files get installed
  too (`.gvimrc` and the `darktooth.vim` colour scheme).

- `zsh/`: contains `zshrc`, and other files that are `source`d from within the
  main `zshrc` file.  These are only installed if `zsh` is installed _and_
  available as a shell on your system (check `/etc/shells`).  `~/.zshrc` is
  created as a symlink to `dotfiles/zsh/zshrc`.

### Rationale

To an extent, _uninstallation_ of these dotfiles should be easy: the
installation is designed to _fail_ or _skip a step_ if it detects
a file/directory that already exists, rather than overwriting anything.  Most
configuration files are _symlinked_ rather than being copied into the
filesystem, meaning that you can remove the symlinks and return your system to
the state pre-dotfiles.

**There are exceptions** to this, however: these include (but are not
necessarily limited to) `.zshrc`, `.vimrc`, `.gvimrc`, `.gitignore`,
`.gitconfig` and `.tmux.conf`, all of which are installed in your home
directory.  **If these files already exist, they will be overwritten.**  This is
because the main use case for these dotfiles is to customise a *fresh system*,
like a new VM, so the existing content of these files is considered unimportant.
If you're installing these on a system where this isn't the case, **let me
know** (read the [introduction section](#introduction)) and I might change this
behaviour.

### How it works

The 'master' installation script is located in `install.sh`, and this sources
the other files under `install/` after attempting to update the dotfiles.

The installation process is designed to be unattended, so that you can set it
going and enjoy your coffee/tea/other beverage.  For this same reason, if you
have `zsh` installed and want to use the `zsh` environment that gets set up, you
need to manually `chsh` your shell to `/bin/zsh` or `/usr/bin/zsh` (depending on
where `zsh` gets installed -- use `which zsh` to check).  This command can
sometimes require entry of your login password as a security measure, which
would make the installation process non-unattended if `chsh` were called!

(The longest part of the installation is probably the downloading of Vim
plugins, so if your internet speed is slow then you may wish to cut down on how
many plugins are downloaded, or run `:PluginUpdate` yourself later on.  See
`vim/.vimrc` and `install/vim.sh`.)
