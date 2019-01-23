" ~/.vimrc


" Use vim enhancements over old vi compatibility
set nocompatible

" Enable modelines
" Search the first and last 5 lines
set modeline
set modelines=5

" Set the status line the way Derek Wyatt likes it
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" Always display the status line
set laststatus=2

" Show the current mode (Insert, Replace, Visual) on the last line
set showmode

" Show (partial) command in the last line of the screen
set showcmd

" Keep 50 lines of command line history
set history=50

" Show current column and row position
set ruler

" Display line numbers
set number

" Enable syntax highlighting
syntax on

" Enable file type detection
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc
" Also load indent files, to automatically do language-dependent indenting
filetype plugin indent on

" Display a vertical line at column 80
set colorcolumn=80

" Highlight all search matches
" Turn off highlight with :noh
set hlsearch

" Do incremental searching
set incsearch

" Perform case insensitive searching
set ignorecase

" Typing small case will search case independent
" Typing mixed case will use exact
set smartcase

" Hide buffers instead of closing them
" Open a new buffer without writing changes to current buffer
set hidden

" Disable background color erase
" Vim extends the color scheme's background color to the whole terminal screen
set t_ut=

" Enable 256 colors in vim
set t_Co=256

" Set the width of a TAB to 8
" Still it is a \t. Vim will interpret it to have a width of 8
set tabstop=8

" Do not expand tab to spaces
set noexpandtab

" Indentation will have a width of 8
set shiftwidth=8

" Vim will use 8 columns when hitting tab in insert mode
set softtabstop=8

" Automatically wrap text as close to 79 characters
" as white space allows without exceeding the 79 character limit
set textwidth=80

" Put a dollar sign up to the point of editing when using the c command
set cpoptions+=$

" Disable mouse support
set mouse=

" Disable beeping (aka "bell") and window flashing
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinLeave * call clearmatches()

" Enable spell checking
set spelllang=en_us,el
set spellfile=~/.vim/spell/en.utf-8.add
set spell

" Enable the "ctrlp.vim" plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Do not auto indent the line when a colon is inserted
" http://stackoverflow.com/questions/19320747/prevent-vim-from-indenting-line-when-typing-a-colon-in-python
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:

" Enable Tim Popes' pathogen
execute pathogen#infect()

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }

" Run Flake8
" https://github.com/nvie/vim-flake8
autocmd BufWritePost *.py call Flake8()
let g:flake8_show_in_gutter = 1

" Settings for html files
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab shiftwidth=2 softtabstop=2 textwidth=0 colorcolumn=0

" Set the Normal group background terminal color to none
" so that vim has the same transparency as xterm
highlight Normal ctermbg=none

" Set the color scheme
"set background=dark
let g:solarized_termcolors=256
colorscheme solarized
colorscheme xoria256
colorscheme monokai
colorscheme mustang

" Do not maintain a history file of all the directories that were modified
let g:netrw_dirhistmax = 0

" Get nice 2-space YAML files
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell
