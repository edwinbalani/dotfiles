" edwinbalani's .vimrc

" Vundle
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'hdima/python-syntax'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'tacahiroy/ctrlp-funky'

call vundle#end()
filetype plugin indent on
syntax on

" Consolidate temporary files in a central spot
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap

" Always show Vim Airline
set laststatus=2

" Set concealing (mainly for Markdown currently)
set conceallevel=2

" Set colour scheme
" colorscheme

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Set leader key and show when it's typed
let mapleader = ","
set showcmd

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" NERDTree hotkey
noremap <F4> :NERDTreeToggle<CR>

" CtrlP bindings
nnoremap <leader>f :CtrlPBuffer<CR>
nnoremap <leader>n :CtrlPFunky<CR>
nnoremap <leader>l :CtrlPLine<CR>
" Better tabs
set tabstop=4       " \t characters in files are shown as 4 spaces
set softtabstop=4   " Insert 4 spaces for <Tab> in Insert mode
set shiftwidth=4    " >> and << commands move by 4 spaces too
set shiftround      " >> and << correct funny indentation to 4 spaces
set expandtab       " Always indent with spaces, not \t characters

" Various display and insert mode options
set nowrap        " No line wrapping
set backspace=indent,eol,start  " Backspace across all boundaries
set autoindent  " Auto-indent new lines
set copyindent  " Follow previous line's indentation
set showmatch   " Show matching brackets
set ignorecase  " Ignore search case
set smartcase   " Only ignore case if pattern is all-lowercase
set smarttab    " Insert tabs following shiftwidth, not tabstop

" Search options
set hlsearch    " Highlight search matches
set incsearch   " Move to search matches as you type
nnoremap <leader>/ :nohlsearch<CR>   " Temporarily kill search highlighting

set history=1000
set undolevels=1000
set title       " Let Vim manipulate the terminal title

" Line numbering
set number
set relativenumber
set numberwidth=5

" Toggle relative line numbering
nnoremap <leader>n :set relativenumber!<CR>

" Keep Visual selection after indenting
vnoremap > >gv
vnoremap < <gv

" Show lines that extend off-screen or with misbehaving whitespace
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅,extends:#

" Hide buffers instead of closing them
set hidden

" 'Dumb' paste mode hotkey
set pastetoggle=<F3>

" Better Python syntax highlighting
let python_highlight_all=1

" Pandoc editing
"let g:pandoc#command#autoexec_on_writes=1
"let g:pandoc#command#autoexec_command = "Pandoc! pdf"

" Quick .vimrc editing
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Working with assembly in general
autocmd FileType asm,s nnoremap <leader>a :e %:r.asm<CR>
autocmd FileType asm,s nnoremap <leader>l :e %:r.lst<CR>
autocmd FileType asm,s set tabstop=8
autocmd FileType asm,s set shiftwidth=8
autocmd FileType asm,s set shiftround
autocmd FileType asm,s set noexpandtab

" Working with PIC assembly specifically
autocmd FileType asm nnoremap <leader>p :w<CR>:!echo;echo;gpasm %:r.asm && pickit %:r.hex<CR>
autocmd FileType asm nnoremap <leader>m :w<CR>:!gpasm -m %:r.asm<CR>

" Working with AVR assembly specifically
autocmd FileType s nnoremap <leader>p :w<CR>:echoe "TODO: add assemble+flash commands"<CR>
autocmd FileType s nnoremap <leader>m :w<CR>:echoe "TODO: add memory dump command"<CR>

" Write/preview Pandoc output with "notes" template
nnoremap <leader>nw :Pandoc #notes<CR>
nnoremap <leader>np :Pandoc! #notes<CR>

