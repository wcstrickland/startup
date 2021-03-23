set nocompatible              " be iMproved, required
filetype off                  " required

"GIT COMMAND FOR INSTALLING VUNDLE"
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"

" set the runtime path to include Vundle and initialize "
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required "
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'w0rp/ale'
Plugin 'luochen1990/rainbow'
Plugin 'tpope/vim-surround'
Plugin 'PhilRunninger/nerdtree-buffer-ops'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-fugitive'
Plugin 'joshdick/onedark.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'valloric/youcompleteme' "

" All of your Plugins must be added before the following line "
call vundle#end()            " required
filetype plugin indent on    " required

" Put your non-Plugin stuff after this line

"color scheme stuff"
if (has("termguicolors"))
    set termguicolors
endif
syntax on
colorscheme onedark
let g:airline_theme='onedark'
let g:rainbow_active = 1 "default to rainbow brackets on"
set number "default to numberd lines"
set hlsearch

"tab formatting"
set termwinsize=10*0  "default terminal size"
set tabstop=4 "number of spaces per tab"
set shiftwidth=4 "indent size"
set expandtab "tabs are 4 spaces"
set splitbelow "causes splits below"
set clipboard=unnamed "allows pasting from OS clipboard"
au VimEnter *  NERDTree "open tree as vim opens"
let g:NERDTreeWinSize=20  "default tree width"
inoremap jj <Esc>  
nnoremap ff :NERDTreeToggle<CR> 

"code folding" 
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 

"vim 8 basic autocomplete comment out if using you complete me"
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <S-Space> <C-n>

"shift n will search the word under the cursor
nnoremap <S-n> :/\<<C-r><C-w>\><CR>
"returning to normal mode will turn off highlighting"
nnoremap mm :silent! nohls<cr>

"a div and component shortcut""
nnoremap <leader>d i<div className=""><CR><CR></div><esc>kkf"a
nnoremap <leader>c i</><esc>hi


