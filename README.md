# edwinbalani's dotfiles

## Contents

* [Introduction](#introduction)
* [Licence](#licence)
* [Recommended programs](#recommended-programs)
* [Installation](#installation)
   * [Requirements](#requirements)
   * [One line to install](#one-line-to-install)
* [Technical information](#technical-information)
   * [Directory structure](#directory-structure)
   * [Rationale](#rationale)
   * [How it works](#how-it-works)

## Introduction

Congratulations if you've found these.  Note that they're mainly for my own use,
and thus have some opinionated personalisations that I find useful.

You _could_ use these dotfiles as-is, if you want to, but certain things will be
very unhelpful to you (like my [`.gitconfig`](config/.gitconfig)). They also
come with **no warranty or guarantee of quality**.  (If your computer catches
fire, becomes sentient or otherwise ruins your life as a result of using these
dotfiles, then it's not my fault.  Do let me know if that happens though,
because if my measly dotfiles caused that to happen then it would be _really
cool_.)

If you have any suggestions on how these could be improved, please do open an
issue or (better) fork, tweak, and submit a pull request.

## Licence

[MIT License](COPYING).


## Recommended programs

To make the most of these dotfiles, it is _highly recommended_ that you install
these programs (and in parenthesis is why):

- `zsh` (I use [antigen](https://github.com/zsh-users/antigen)heavily)
- `vim` (and optionally `gvim` if you're in a graphical environment)
- `tmux` (helpful alias `att` and `tls`, and [`.tmux.conf`](config/.tmux.conf))

A few that are more optional:

- `thefuck` (you can use either `fuck`, `oops` (SFW) or double-`Esc` to invoke
  this)
- **both** `fortune` **and** `cowsay` (a nice shell startup message ;) )

_(If you're not a fan of any of these programs, you're probably in the wrong
place.  These dotfiles are mainly for my own use, are customised for myself
above anything else.)_


## Installation

### Requirements

 - `git` to keep the repository updated (and, er, to clone it in the first place)
 - `bash` for the install script

### One line to install

```bash
$ git clone https://github.com/edwinbalani/dotfiles.git ~/dotfiles && ~/dotfiles/install.sh
```

**WARNING:** You should [make a backup](#rationale) of any existing dotfiles
before you run this.  In many cases, you won't have any, or they'll be system
defaults that you don't care about (if you're installing this onto a fresh
computer or account).

The installation script is tried and tested heavily on 'full-fat' desktop and
server installations of Ubuntu 16.04 -- other Linux distros less so.  I don't
expect it to work on BSD/macOS systems, but you may get lucky.

If you run into a bug with the script on your setup, and have fixed it, submit
a pull request so I can merge the changes back in!


## Technical information

_Read this section if you're interested in how these dotfiles install themselves
on your computer, or if you're thinking of hacking on them.  It's not mandatory,
though; you can just run `install.sh` and be happy._

### Directory structure

- `config/`: contains 'singleton' files to be symlinked directly into \$HOME
  (e.g. `.gitconfig`, `.tmux.conf`)

- `install/`: contains the installation scripts for the dotfiles.  They're
  broken up into multiple files, each of which serves to install a certain
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
  available as a login shell on your system (we check `/etc/shells` to do this).
  `~/.zshrc` is **overwritten** (see below) as a symlink to
  `dotfiles/zsh/zshrc`.

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
many plugins are downloaded, or run `:PluginUpdate` yourself later on.  Edit
`vim/.vimrc` and `install/vim.sh` before running `install.sh`.)
