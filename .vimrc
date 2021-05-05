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

Plug 'mg979/vim-visual-multi'
" Plug 'ctrlpvim/ctrlp.vim'
"
Plug 'easymotion/vim-easymotion'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'bling/vim-airline'

Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'

call plug#end()

colo molokai
if has("gui_vimr")
	 let g:molokai_original = 1
endif

nnoremap <c-p> :Files<cr>

" " ctrlp settings
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlPMixed'
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
"
"
" easymotoin settings
"
let g:EasyMotion_do_mapping = 0

nmap s <Plug>(easymotion-overwin-f2)
nmap gw <Plug>(easymotion-overwin-w)
let g:EasyMotion_keys = 'sadfjklewcmpgh'

let g:EasyMotion_smartcase = 1


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

let g:VM_maps = {}
let g:VM_maps["Switch Mode"] = 'v'
let g:VM_maps['Find Under']                  = '<C-n>'
let g:VM_maps['Find Subword Under']          = '<C-n>'
let g:VM_maps["Add Cursor Down"]             = '<C-j>'
let g:VM_maps["Add Cursor Up"]               = '<C-k'

let g:VM_maps["Align"]                       = 'ga'
let g:VM_maps["Visual Cursors"]              = 'gl'


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


" incremental search
set incsearch
set hlsearch


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



