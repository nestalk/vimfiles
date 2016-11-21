autocmd!

set nocompatible
set hidden
set t_Co=256
set background=dark
set relativenumber
set autoread 

set cmdheight=1
set showtabline=2
set winwidth=79
set showcmd
set switchbuf=useopen
set ruler

set t_ti= t_te=

set showmatch

set encoding=utf8

set si

set nobackup
set nowb
set noswapfile

set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" Vundle
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'elixir-lang/vim-elixir'
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()
filetype plugin indent on

augroup vimrcEx
    autocmd!
    " Jump to last cursor position when opening files
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal g'\"" |
        \ endif

augroup END

" Tab will indent if at start of line, autocomplete otherwise
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" CtrlP command bindings
map <leader>p :CtrlP<CR>
map <leader>y :CtrlPMixed<CR>
map <leader>f :CtrlPClearAllCaches<CR>

" open file in current folder
cnoremap <expr> %% expand('%:h').'/'
map <leader>e :edit %%
map <leader>v :view %%

" Rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr> :view %%

" Change color of ugly dropdown menus
hi PmenuSel ctermfg=DarkGrey ctermbg=Yellow
hi Pmenu ctermfg=LightGrey ctermbg=Blue

" Ignore files when searching
set wildignore=*.o,*.obj,.git,node_modules/**,bower_components/**,**/node_modules/**,_build/**,deps/**

" Elixir

"" Run tests
map <leader><space> :!mix test<CR>

