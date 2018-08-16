
call plug#begin()
Plug 'reedes/vim-pencil'
Plug 'metakirby5/codi.vim'
Plug 'lervag/vimtex'
" Plug 'tpope/vim-sensible'
Plug 'tomasr/molokai'
Plug 'raphamorim/lucario'
Plug 'altercation/vim-colors-solarized'
"
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'svermeulen/vim-easyclip'
Plug 'tpope/vim-repeat'
Plug 'junegunn/vim-easy-align'
Plug 'ervandew/supertab'
"
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'dragfire/Improved-Syntax-Highlighting-Vim'

Plug 'LucHermitte/VimFold4C'
Plug 'tpope/vim-fugitive'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
"
" Plug 'python-mode/python-mode', {'branch': 'develop'}
" Plug 'python-mode/python-mode'
Plug 'davidhalter/jedi-vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'

Plug 'skywind3000/asyncrun.vim'
Plug 'tmhedberg/simpylfold'
Plug '907th/vim-auto-save'
Plug 'chrisbra/csv.vim'
"
" Plug 'Valloric/YouCompleteMe'
"Plug 'hdima/python-syntax'
"Plug 'dragfire/improved-syntax-highlighting-vim'
"Plug 'sheerun/vim-polyglot'
" Plug 'sentientmachine/pretty-vim-python'
"

Plug 'dag/vim-fish'
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

set foldlevel=99
set clipboard=unnamedplus
" nnoremap <esc> :noh<return><esc>
set spell
set mouse=a

let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_insert_maps = {'j':1}
nnoremap gm m

" let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'
let g:SuperTabContextDefaultCompletionType = "<c-n>"

xmap ga <Plug>(EasyAlign)

" Python config
au BufNewFile,BufRead *.py set tabstop=4|
    \set softtabstop=4|
    \set shiftwidth=4|
    \set textwidth=120|
    \set expandtab|
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

let g:pymode_rope = 0
let g:pymode_lint_cwindow = 0

"let python_highlight_builtins = 1
"let g:pymode_python = 'python3'

" autocmd Filetype python setlocal makeprg="python %"
" nnoremap <M-B> :make<CR>
"
autocmd FileType python map <buffer> <Leader>l :call Flake8()<CR>
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1

autocmd VimLeave * call system("xclip -o | xclip -selection c")

autocmd VimLeave * call system("xsel -ib", getreg('+'))

map <C-A>j <C-W>j
map <C-A>k <C-W>k

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

set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

nnoremap <F5> :call <SID>compile_and_run()<CR>

augroup SPACEVIM_ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END


function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python %"
    endif
endfunction

" VIMTEX SETTINGS 
autocmd FileType tex,txt,md nnoremap j gj
autocmd FileType tex,txt,md nnoremap k gk

let g:vimtex_view_method = 'skim'
" let g:vimtex_view_general_viewer
"       \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
" let g:vimtex_latexmk_options = '-pdf -verbose -bibtex -file-line-error -synctex=1 --interaction=nonstopmode'

" let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
let g:vimtex_compiler_callback_hooks = ['UpdateSkim']

function! UpdateSkim(status)
  if !a:status | return | endif

  let l:out = b:vimtex.out()
  let l:tex = expand('%:p')
  let l:cmd = [g:vimtex_view_general_viewer, '-r']
  if !empty(system('pgrep Skim'))
    call extend(l:cmd, ['-g'])
  endif
  if has('nvim')
    call jobstart(l:cmd + [line('.'), l:out, l:tex])
  elseif has('job')
    call job_start(l:cmd + [line('.'), l:out, l:tex])
  else
    call system(join(l:cmd + [line('.'),
          \ shellescape(l:out), shellescape(l:tex)], ' '))
  endif
endfunction


" autocmd FileType tex call Tex_SetTeXCompilerTarget('View','pdf')     
