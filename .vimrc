"soruce configuration for cscope"
source ~/.vim/cscope_maps.vim

"source configuration for powerline"
set rtp+=/usr/share/powerline/bindings/vim

"path to plugins"
set runtimepath+=~/.vim/NERD_tree

"auto load plugins"
"autocmd vimenter * if !argc() | NERDTree | endif"
autocmd BufWinEnter * if !argc() | NERDTreeMirror | endif"

"configure nerd tree"
let NERDTreeShowHidden=1

"configure vim"
set number
set relativenumber
set completeopt=longest,menuone
set mouse=a
set ttymouse=xterm2
set ts=4
set shiftwidth=4
set hlsearch
set cursorline
hi CursorLine   cterm=NONE ctermbg=8

"configure netrw"
let g:netrw_banner=0
let g:netrw_liststyle=3

"configure powerline"
" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

"colorscheme"
set background=dark

" minimal configuration for c/c++
set enc=utf-8
set fenc=utf-8

" disable vi compatibility (emulation of old bugs)
set nocompatible

" use indentation of previous line
" not working in make files
set autoindent 

" use intelligent indentation for C
set smartindent

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
"set expandtab        " expand tabs to spaces

" turn syntax highlighting on
syntax on

" highlight matching braces
set showmatch

" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" open new splits right or bellow
" instead of left and up from current window
set splitbelow
set splitright

" add aditional key mappings from here: https://gist.github.com/rocarvaj/2513367
" SeeTab: toggles between showing tabs and using standard listchars
fu! SeeTab()
    if !exists("g:SeeTabEnabled")
        set list
        set listchars=tab:>_
        let g:SeeTabEnabled = 1
        hi SpecialKey cterm=NONE ctermfg=darkgray gui=NONE
    else
        set listchars=tab:\ \ 
        unlet g:SeeTabEnabled
    endif
endfunc
com! -nargs=0 SeeTab :call SeeTab()

" keyboard shortcuts
" open explorer
map <C-f> :Explore <Enter>
"map <C-s-f> :Sex <Enter>
"map <C-v-f> :Vex <Enter>

" open ctags in vertical split
map <C-}> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

nnoremap st :SeeTab<CR>
nnoremap nt :NERDTree<CR>


"tab navigation
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap ts :tab split<CR>




