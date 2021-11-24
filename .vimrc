if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'vim-scripts/Improved-AnsiEsc'

""" AESTHETICS -----
Plug 'tomasr/molokai'
Plug 'bling/vim-airline'

" fixes matching parentheis being confusigly coloured
autocmd ColorScheme * hi MatchParen cterm=bold ctermbg=black ctermfg=208
" autocmd ColorScheme * hi MatchParen gui=bold guibg=none guifg=#FD971F


""" AUTOCOMPLETE -----
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = '<c-p><c-n>'
" let g:SuperTabContextDefaultCompletionType = "<c-n>"

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'prabirshrestha/asyncomplete-buffer.vim'
" Plug 'high-moctane/asyncomplete-nextword.vim'
" Plug 'prabirshrestha/asyncomplete-file.vim'

let g:lsp_diagnostics_enabled = 0

" set foldmethod=expr
"   \ foldexpr=lsp#ui#vim#folding#foldexpr()
"   \ foldtext=lsp#ui#vim#folding#foldtext()

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    " setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    " nmap <buffer> gr <plug>(lsp-references)
    " nmap <buffer> gi <plug>(lsp-implementation)
    " nmap <buffer> gt <plug>(lsp-type-definition)
    " nmap <buffer> <leader>rn <plug>(lsp-rename)
    " nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    " nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> gK <plug>(lsp-hover)
    " inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    " inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    " let g:lsp_format_sync_timeout = 1000
    " autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Plug 'liuchengxu/vista.vim'
" let g:vista_executive_for = {
"         \ 'cpp': 'vim_lsp',
"         \ 'python': 'vim_lsp',
"         \ }
" let g:vista_ignore_kinds = ['Variable']
" let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]


""" EXTRA COMMANDS -----
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'

Plug 'mg979/vim-visual-multi'
let g:VM_maps = {}
let g:VM_maps["Switch Mode"] = 'v'
let g:VM_maps['Find Under']                  = '<C-n>'
let g:VM_maps['Find Subword Under']          = '<C-n>'
let g:VM_maps["Add Cursor Down"]             = '<C-j>'
let g:VM_maps["Add Cursor Up"]               = '<C-k'

let g:VM_maps["Align"]                       = 'ga'
let g:VM_maps["Visual Cursors"]              = 'gl'

" Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
nmap gw <Plug>(easymotion-overwin-f2)
" nmap s <Plug>(easymotion-overwin-w)
nmap <Space> <Plug>(easymotion-overwin-w)
let g:EasyMotion_keys = 'sadfjklewcmpgh'

let g:EasyMotion_smartcase = 1


""" FOLDING ----
Plug 'tmhedberg/SimpylFold'
" opens all folds on loading file
autocmd BufWinEnter * silent! :%foldopen!

" https://stackoverflow.com/questions/61795798/recalculating-folds-in-vim-without-applying-foldlevel
au InsertLeave,TextChanged *.py set foldmethod=expr


""" COPY PASTE BEHAVIOUR ----

" paste in insert mode
inoremap <C-v> <C-r>"

" https://issueexplorer.com/issue/rafi/vim-config/145
" set clipboard=unnamedplus
set clipboard& clipboard^=unnamed,unnamedplus

" Plug 'svermeulen/vim-easyclip'
let g:EasyClipUseSubstituteDefaults = 1
" noremap <c-]> <plug>EasyClipSwapPasteForward
" noremap <c-[> <plug>EasyClipSwapPasteBackward

Plug 'svermeulen/vim-cutlass' "delete operations no longer yank
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D

" allows mark to be accessed
nnoremap gm m

Plug 'svermeulen/vim-subversive' "adds substitution opperator
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)


"TODO (add the paste rotate behaviour)
" Plug 'svermeulen/vim-yoink' "maintains yank history and allows rotating.
" nmap <c-[> <plug>(YoinkPostPasteSwapBack)
" nmap <c-]> <plug>(YoinkPostPasteSwapForward)
" nmap p <plug>(YoinkPaste_p)
" nmap P <plug>(YoinkPaste_P)

" nmap [y <plug>(YoinkRotateBack)
" nmap ]y <plug>(YoinkRotateForward)
" let g:yoinkIncludeDeleteOperations = 1


""" SEARCH PALETTES  -----
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"TODO
nnoremap <c-p> :GFiles<cr>
" nnoremap <c-P> :Commands<cr> " can't fo shift+ctrl
nnoremap <C-l> :Rg <CR>
nnoremap <C-d> :Ex <CR>

" modified to ignore venv directory content
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --iglob !venv --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" makes using fzf remember location in file
" autocmd BufEnter * silent! normal! g`"
" :se nostartofline
"
" makes it remeber the fold state and location in file
augroup remember_folds
	" autocmd!
	" autocmd BufWinLeave * mkview
	" autocmd BufWinEnter * silent! loadview
	autocmd!
	" view files are about 500 bytes
	" bufleave but not bufwinleave captures closing 2nd tab
	" nested is needed by bufwrite* (if triggered via other autocmd)
	" BufHidden for compatibility with `set hidden`
	autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
	autocmd BufWinEnter ?* silent! loadview
augroup END


""" TMUX INTEGRATION -----
"TODO
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'

""" JUPYTER INTEGRATION
Plug 'jpalardy/vim-slime', { 'for': 'python' }
" Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" Plug 'szymonmaszke/vimpyter' "vim-plug # notedown
Plug 'anosillus/vim-ipynb' "vim-plug # ipynb-py-convert
" Plug 'goerz/jupytext.vim' "vim-plug # jupytext

let g:slime_target = 'tmux'

" fix paste issues in ipython
let g:slime_python_ipython = 1

let g:slime_cell_delimiter = "# %%"
let g:slime_default_config = {"socket_name": "default", "target_pane": "2"}
let g:slime_dont_ask_default = 1

nmap g<CR> <Plug>SlimeSendCell

""" DISCOVERABILITY -----
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" need to set leader 

""" ?????? -----
set nocompatible
" filetype plugin indent on

" Plug 'samoshkin/vim-mergetool'

" let g:mergetool_layout = 'mr'
" let g:mergetool_prefer_revision = 'local'
" nmap \mt <plug>(MergetoolToggle)

call plug#end()

function! TmuxCopyViewer()
  set nonumber
  AnsiEsc
  let g:airline_disable_statusline = 1
  %s#\($\n\)\+\%$##
  set ve+=onemore
  normal! G$l
endfunction
command! TmuxCopyViewFunc call TmuxCopyViewer()

""" ENABLE COLOSCHEME
colo molokai
if has("gui_vimr")
	 let g:molokai_original = 1
endif

""" STANDARD SETTING -----
inoremap jk <Esc>

set number
" set relativenumber
set cursorline
syntax on

" incremental search
set incsearch
set hlsearch

"save shortcut
command W w



""" LANGUAGE SPECIFICS

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


""" MANAULLY PROGRAMED BEHAVIOUR

"caused issues 
"nnoremap <esc> :noh<return><esc>

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


" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

"remaps join line to L to prevent shadowing
nnoremap L J 

" Allows for scrolling while keeping cursor on screen
" https://vim.fandom.com/wiki/Combining_move_and_scroll
function! s:Saving_scroll(cmd)
  let save_scroll = &scroll
  execute 'normal! ' . a:cmd
  let &scroll = save_scroll
endfunction
nnoremap J :call <SID>Saving_scroll("2<C-V><C-D>")<CR>
vnoremap J <Esc>:call <SID>Saving_scroll("gv2<C-V><C-D>")<CR>
nnoremap K :call <SID>Saving_scroll("2<C-V><C-U>")<CR>
vnoremap K <Esc>:call <SID>Saving_scroll("gv2<C-V><C-U>")<CR>



call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

" call asyncomplete#register_source(asyncomplete#sources#nextword#get_source_options({
"             \   'name': 'nextword',
"             \   'allowlist': ['*'],
"             \   'args': ['-n', '10000'],
"             \   'completor': function('asyncomplete#sources#nextword#completor')
"             \   }))

" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
"     \ 'name': 'file',
"     \ 'allowlist': ['*'],
"     \ 'priority': 10,
"     \ 'completor': function('asyncomplete#sources#file#completor')
"     \ }))

