" Execute Plugin
execute pathogen#infect()

" basics
set backspace=2         " backspace in insert mode works like normal editor
syntax on               " syntax highlighting
filetype plugin indent on      " activates indenting for files
set autoindent          " auto indenting
set number              " line numbers
set nobackup            " get rid of ~file
set paste		         " why not?
set ttyfast             " Assume a fast terminal
set tabstop=3           " 
set fileformat=unix     " 

" tabs n spaces    
" What python likes => Makefiles do not!
" For Makefiles :set noexpandtab and then :retab! 
set expandtab		        " tabs to whitespace


" BEEP FREE
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
    
    
" Coralle backup files away from working folder
" --> Since all files end up in same folder
"       --> Then files get overwritten. TODO: FIX!
set backupdir=~/.vim/backup
set backup
set directory=~/.vim/tmp


" Plugin Configurations

" Git gutter
let g:gitgutter_sign_column_always = 0


" Tag Bar
nmap <F8> :TagbarToggle<CR>

" Good enough Syntax highlighting/ indenting for Racket via scheme
"if has("autocmd")
"    au BufReadPost *.rkt,*.rktl set filetype=scheme
"endif
