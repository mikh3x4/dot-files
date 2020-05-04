if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tomasr/molokai'

Plug 'tpope/vim-commentary'
" Plug 'justinmk/vim-sneak'
Plug 'svermeulen/vim-easyclip'
Plug 'tpope/vim-repeat'

Plug 'ervandew/supertab'

Plug 'bling/vim-airline'
call plug#end()

colo molokai
if has("gui_vimr")
	 let g:molokai_original = 1
endif

inoremap jk <Esc>

set number
set relativenumber
set cursorline
syntax on

"nnoremap <esc> :noh<return><esc>
nnoremap gm m

let g:EasyClipUseSubstituteDefaults = 1

" let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" Python config
au BufNewFile,BufRead *.py
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set textwidth=120
    \set expandtab
    \set autoindent
"     \set fileformat=unix

" C config
au BufNewFile,BufRead *.cc,*.c,*cpp,*.h,*.hpp set tabstop=4|
    \set softtabstop=4|
    \set shiftwidth=4|
    \set textwidth=120|
    \set expandtab|
    \set autoindent
"     \set fileformat=unix

" makes enter key highlight word under cursor
let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <CR> Highlighting()
" vnoremap <silent> <expr> <CR> Highlighting()



