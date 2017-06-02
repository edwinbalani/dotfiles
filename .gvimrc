if filereadable("/etc/vim/gvimrc.local")
  source /etc/vim/gvimrc.local
endif

syntax on
colorscheme darktooth

if has('gui_gtk2')
  set guifont=DejaVu\ Sans\ Mono\ 11
else
  set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
endif

