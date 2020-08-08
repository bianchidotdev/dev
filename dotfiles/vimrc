" Custom Config
let mapleader=","
nnoremap <leader>p :r pbpaste
" Make space more useful
nnoremap <space> za

" folding
set foldmethod=indent
set foldnestmax=1
set nofoldenable
set foldlevel=2


" Standard Config
syntax on " Highlight the keywords based on filetype

filetype indent on " Enable file type based indentation
filetype plugin on " Enable file type based plugins

set ruler " Display the current line number in the status bar
set autoindent " New lines will keep the previous indentation
set ignorecase " When searching (/) will ignore the case of the input
set smartcase " Don't ignore case when the term contains any uppercase
" :set paste " To ignore auto-indent when pasting from the clipboard
set hlsearch " Highlight search results. To clear use :noh
set incsearch " Search incrementally, as you type
set backspace=indent,eol,start

set tabstop=2  " 2 space= 1 tab
set softtabstop=4  " unify
set shiftwidth=2  " Indent is 2 spaces
set shiftround  " always indent/outdent to the nearest tabstop

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)

" Enable line numbers
set number
" show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Plugins

" If no vim-plug, grab that first and install plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"" Create function to compile youcompleteme after installation
"function! BuildYCM(info)
  "" info is a dictionary with 3 fields
  "" - name:   name of the plugin
  "" - status: 'installed', 'updated', or 'unchanged'
  "" - force:  set on PlugInstall! or PlugUpdate!
  "if a:info.status == 'installed' || a:info.force
    "!./install.py
  "endif
"endfunction

call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
"Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
"Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'fatih/vim-go'
Plug 'airblade/vim-gitgutter'
Plug 'rust-lang/rust.vim'

call plug#end()

" Solarized stuff
"silent! colorscheme solarized
" colorscheme solarized

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
"
" " better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

let g:ultisnips_python_style = "0x3"

" Go Aliases
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

" Rust Settings
let g:rustfmt_autosave = 1
