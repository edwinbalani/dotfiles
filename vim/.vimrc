" edwinbalani's .vimrc

set encoding=utf-8
scriptencoding utf-8

set nocompatible
filetype off

source ~/.vim/autoload/plug.vim

call plug#begin('~/.vim/bundle')
"Plug 'scrooloose/nerdcommenter'
"Plug 'scrooloose/nerdtree'
"Plug 'mxw/vim-jsx'
"Plug 'file:///home/edwin/src/vim-terraform-completion'
"Plug 'juliosueiras/vim-terraform-completion'
" sort with :sort i /[^\/]*\//]
if executable('elixir')
    Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
    Plug 'mhinz/vim-mix-format', { 'for': 'elixir' }
    let g:mix_format_on_save = 1
endif
if (v:version >= 800 && has('timers') && has('job') && has('channel')) || has('nvim')
    Plug 'w0rp/ale'
else
    Plug 'vim-syntastic/syntastic'
endif
Plug 'tacahiroy/ctrlp-funky', { 'on': 'CtrlPFunky' }
Plug 'ctrlpvim/ctrlp.vim', { 'on': [ 'CtrlPBuffer', 'CtrlPFunky', 'CtrlPLine', 'CtrlPTag' ] }
Plug 'Raimondi/delimitMate'
Plug 'editorconfig/editorconfig-vim'
if executable('elm')
    Plug 'ElmCast/elm-vim'
endif
Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
" Plug 'davidhalter/jedi-vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'sh install.sh',
    \ }
Plug 'junegunn/limelight.vim'
Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'tpope/vim-abolish'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" 'vim-go requires Vim 7.4.2009 or Neovim 0.3.1'
" copied from https://github.com/fatih/vim-go/blob/master/plugin/go.vim :
if has('nvim-0.3.1') || (v:version > 704) || (v:version == 704 && has('patch2009'))
    Plug 'fatih/vim-go', { 'for': 'go' }
endif
" 'gutentags: this plugin requires the job API from Vim8 or Neovim.'
if executable('ctags') && (has('nvim') || v:version >= 800)
    Plug 'ludovicchabant/vim-gutentags'
endif
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja2' }
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': 'jsx' }
Plug 'mustache/vim-mustache-handlebars'
Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown', 'pandoc']}
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc']}
Plug 'joonty/vim-phpqa', { 'for': 'php' }
Plug 'IN3D/vim-raml', { 'for': 'raml' }
Plug 'tpope/vim-repeat'
Plug 'kelwin/vim-smali'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'Matt-Deacalion/vim-systemd-syntax', { 'for': 'systemd' }
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
" Plug 'ajh17/VimCompletesMe'
call plug#end()
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

" Set leader key and show when it's typed
let mapleader = ","
set showcmd

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

" Don't eagerly tag everything - enable on a project by project basis
let g:gutentags_enabled = 0
nnoremap <leader>gte :let g:gutentags_enabled = 1<CR>
nnoremap <leader>gtd :let g:gutentags_enabled = 0<CR>
nnoremap <leader>gtu :GutentagsUpdate<CR>

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
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" " NERDTree hotkey
" noremap <F4> :NERDTreeToggle<CR>

" CtrlP bindings
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>f :CtrlPFunky<CR>
nnoremap <leader>l :CtrlPLine<CR>
nnoremap <leader>t :CtrlPTag<CR>

" Language server setup
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'c': ['/usr/bin/clangd'],
    \ 'cpp': ['/usr/bin/clangd'],
    \ 'python': ['~/.local/bin/pyls'],
    \ 'css': ['/home/edwin/.nvm/versions/node/v12.2.0/bin/css-languageserver', '--stdio'],
    \ 'scss': ['/home/edwin/.nvm/versions/node/v12.2.0/bin/css-languageserver', '--stdio'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

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
    set listchars=tab:⋅\ ,trail:⋅,nbsp:⋅,precedes:#,extends:#
else
    set listchars=tab:.\ ,trail:*,nbsp:~,precedes:#,extends:#
endif

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

" goyo writing mode
nnoremap <leader>go :Goyo<CR>
nnoremap <leader>gl :Limelight!!<CR>

let g:limelight_conceal_ctermfg = 242
" let g:limelight_conceal_guifg = '#ebdbb2'

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

" Tab settings for various filetypes
" ts : tabstop
" sts: softtabstop
" sw : shiftwidth
" sr : shiftround
" (no)et : (no)expandtab
autocmd FileType asm,s set ts=8 sw=8 sr noet
autocmd FileType html,jinja.html,css,scss,javascript,typescript,elm,terraform,yaml set ts=2 sw=2 sr et
autocmd FileType html set tw=144
autocmd FileType cpp,cc,c,h,hpp,hh,go set ts=4 sw=0 noet
autocmd FileType tex set tw=120 ts=4 sw=0 noet

" Text wrapping on Markdown files (et al.)
autocmd FileType pandoc set tw=80 fo+=tcqron1j

" Email
autocmd FileType mail setl tw=72 fo+=aw listchars=trail:↩ list

" physcomp lab RTL coding convention
autocmd FileType verilog set ts=8 sw=0 sr noet

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
