" edwinbalani's .vimrc

set encoding=utf-8
scriptencoding utf-8

" Vundle
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'scrooloose/nerdtree'
"Plugin 'mxw/vim-jsx'
"Plugin 'file:///home/edwin/src/vim-terraform-completion'
"Plugin 'juliosueiras/vim-terraform-completion'
" sort with :sort i /[^\/]*\//]
if v:version >= 800 && has('timers') && has('job') && has('channel')
    Plugin 'w0rp/ale'
else
    Plugin 'vim-syntastic/syntastic'
endif
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'mattn/emmet-vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'hdima/python-syntax'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-commentary'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
if executable('ctags')
    Plugin 'ludovicchabant/vim-gutentags'
endif
Plugin 'pangloss/vim-javascript'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'MaxMEllon/vim-jsx-pretty'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'tpope/vim-surround'
Plugin 'Matt-Deacalion/vim-systemd-syntax'
Plugin 'hashivim/vim-terraform'
Plugin 'lervag/vimtex'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-vinegar'
Plugin 'ajh17/VimCompletesMe'
call vundle#end()
filetype plugin indent on
syntax on

"" Some vim-terraform-completion keys (Ctrl-K and Ctrl-L) conflict with vim-tmux-navigator, let's remap them
"" Adapted from https://github.com/juliosueiras/vim-terraform-completion/blob/2421e4d/ftplugin/terraform.vim
"augroup TerraformCompleteKeys
    "autocmd!
    "" These two change from Ctrl- to Alt- mappings
    "autocmd VimEnter * autocmd FileType terraform 
    "autocmd VimEnter * autocmd FileType terraform noremap <buffer><silent> <M-K> :call terraformcomplete#GetDoc()<CR>
    "autocmd VimEnter * autocmd FileType terraform noremap <buffer> <M-L> :call terraformcomplete#JumpRef()<CR>
    "" These two are unchanged
    "autocmd FileType terraform noremap <buffer><silent> <leader>a :call terraformcomplete#LookupAttr()<CR>
    "autocmd FileType terraform noremap <buffer><silent> <leader>o :call terraformcomplete#OpenDoc()<CR>
"augroup END

" Enable mouse support in all ('a') modes
set mouse=a

" Syntastic Config
set statusline+=%#warningmsg#
if exists('g:loaded_syntastic_plugin')
    set statusline+=%{SyntasticStatuslineFlag()}
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
endif
set statusline+=%*

" vim-mustache-handlebars shortcuts
let g:mustache_abbreviations = 1

"let g:terraformcomplete_map_getdoc = "^[k"
"let g:terraformcomplete_map_jumpref = "^[l"
"let g:terraformcomplete_mappings = 0

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

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" NERDTree hotkey
noremap <F4> :NERDTreeToggle<CR>

" CtrlP bindings
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>f :CtrlPFunky<CR>
nnoremap <leader>l :CtrlPLine<CR>

" Tab settings
set tabstop=8       " \t characters in files are shown as 8 spaces
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

" Temporarily kill search highlighting
nnoremap <leader>/ :nohlsearch<CR>

set history=1000
set undolevels=1000
set title       " Let Vim manipulate the terminal title

" Line numbering
set number
set relativenumber
set numberwidth=5

" Toggle line numbering options
nnoremap <leader>xn :set number!<CR>
nnoremap <leader>xx :set relativenumber!<CR>

" Keep Visual selection after indenting
vnoremap > >gv
vnoremap < <gv

" Show lines that extend off-screen or with misbehaving whitespace
set list
if has('multi_byte')
    set listchars=tab:⋅\ ,trail:⋅,nbsp:⋅,extends:#
else
    set listchars=tab:.\ ,trail:*,nbsp:~,extends:#
endif
"set listchars=tab:▷⋅,trail:⋅,nbsp:⋅,extends:#

" Hide buffers instead of closing them
set hidden

" 'Dumb' paste mode hotkey
set pastetoggle=<F3>

" Better Python syntax highlighting
let python_highlight_all=1

" Pandoc editing
"let g:pandoc#command#autoexec_on_writes=1
"let g:pandoc#command#autoexec_command = "Pandoc! pdf"

" Vimtex setup with zathura & synctex
let g:vimtex_view_method = 'zathura'
"" We'll start the viewer ourselves with <localleader>lv so that synctex works
let g:vimtex_view_automatic = 1

" Quick .vimrc editing
nnoremap <leader>ev :tabe $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Django helpers
" from http://stevelosh.com/blog/2011/06/django-advice/#filetype-mappings
nnoremap _dt :set ft=htmldjango<CR>
nnoremap _pd :set ft=python.django<CR>
au BufNewFile,BufRead admin.py     setlocal filetype=python.django
au BufNewFile,BufRead urls.py      setlocal filetype=python.django
au BufNewFile,BufRead models.py    setlocal filetype=python.django
au BufNewFile,BufRead views.py     setlocal filetype=python.django
au BufNewFile,BufRead settings.py  setlocal filetype=python.django
au BufNewFile,BufRead forms.py     setlocal filetype=python.django

" cd to current file's directory
nnoremap <leader>xc :cd %:h<CR>

" Working with assembly in general
autocmd FileType asm,s nnoremap <leader>a :e %:r.asm<CR>
autocmd FileType asm,s nnoremap <leader>l :e %:r.lst<CR>

" Working with PIC assembly specifically
autocmd FileType asm nnoremap <leader>p :w<CR>:!echo;echo;gpasm %:r.asm && pickit %:r.hex<CR>
autocmd FileType asm nnoremap <leader>m :w<CR>:!gpasm -m %:r.asm<CR>

" Working with AVR assembly specifically
autocmd FileType s nnoremap <leader>p :w<CR>:echoe "TODO: add assemble+flash commands"<CR>
autocmd FileType s nnoremap <leader>m :w<CR>:echoe "TODO: add memory dump command"<CR>

" Write/preview Pandoc output with templates
autocmd FileType pandoc nnoremap <leader>nw :w<CR>:Pandoc #inch<CR>
autocmd FileType pandoc nnoremap <leader>npw :w<CR>:Pandoc! #inch<CR>
autocmd FileType pandoc nnoremap <leader>nn :w<CR>:Pandoc #notes<CR>
autocmd FileType pandoc nnoremap <leader>npn :w<CR>:Pandoc! #notes<CR>
autocmd FileType pandoc nnoremap <leader>nd :w<CR>:Pandoc #docx<CR>
autocmd FileType pandoc nnoremap <leader>npd :w<CR>:Pandoc! #docx<CR>
autocmd FileType pandoc set wrap " Override the default nowrap setting above

" Use tabs in BIND config files
autocmd FileType bindzone,named set softtabstop=0
autocmd FileType bindzone,named set shiftwidth=0
autocmd FileType bindzone,named set shiftround
autocmd FileType bindzone,named set noexpandtab
"" Disable Tab completion mapping
autocmd FileType bindzone,named silent! iunmap <Tab>
autocmd FileType bindzone,named set listchars=tab:\ \ ,trail:⋅,nbsp:⋅,extends:#

" Tab settings for various filetypes
autocmd FileType asm,s set tabstop=8 shiftwidth=8 shiftround noexpandtab
autocmd FileType html,css,javascript,terraform,yaml set softtabstop=2 shiftwidth=2
autocmd FileType cpp,cc,c,h,hpp,hh set tabstop=4 shiftwidth=0 noexpandtab
autocmd FileType tex set tw=120 ts=4 sw=0 noet

" Text wrapping on Markdown files (et al.)
autocmd FileType pandoc set tw=80 fo+=tcqron1j
