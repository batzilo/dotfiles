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

" Set the Normal group background terminal color to none
" so that vim has the same transparency as xterm
highlight Normal ctermbg=none

" Set the color scheme
set background=dark
let g:solarized_termcolors=256
" colorscheme solarized
" colorscheme xoria256
" colorscheme monokai
" colorscheme mustang
colorscheme mustang

" Do not maintain a history file of all the directories that were modified
let g:netrw_dirhistmax = 0

" " Setting for folding
" "
" " Fold based on indent
" set foldmethod=indent
" " Do not fold by default
" set nofoldenable
" " The number of | or numbers displayed
" set foldcolumn=1
" " The deepest fold is 10 levels
" " set foldnestmax=10
set foldmethod=manual

" vim-plug automatic installation
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" after adding this lines, restart vim (maybe twice)
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Use vim-plug
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes

" See https://github.com/junegunn/vim-plug/blob/master/README.md

" Install ctrlp
Plug 'https://github.com/ctrlpvim/ctrlp.vim'

" On-demand loading
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

" Install syntastic
" FIXME: Switch to ALE: https://github.com/dense-analysis/ale
Plug 'https://github.com/vim-syntastic/syntastic'

" Install vim-flake8
Plug 'https://github.com/nvie/vim-flake8'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" Restart Vim, and run the :PlugInstall statement to install your plugins.

" Start NERDTree when Vim is started without file arguments or when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
  \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Configure ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

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
let g:syntastic_python_checkers = ['flake8']

" Do not auto indent the line when a colon is inserted
" http://stackoverflow.com/questions/19320747/prevent-vim-from-indenting-line-when-typing-a-colon-in-python
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:

" Settings for html files
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab shiftwidth=2 softtabstop=2 textwidth=0 colorcolumn=0

" Get nice 2-space YAML files
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell
" Do not auto indent the line when a # is inserted
autocmd FileType yaml setlocal indentkeys-=0#

" Get nice SH files with tabs
autocmd FileType sh setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab nospell

" Get nice 2-space JS files
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell

" Get nice 2-space Java files
autocmd FileType java setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell

" Get nice 2-space Groovy files
autocmd FileType groovy setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell

" Get nice 2-space c files
autocmd FileType c setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell

" Get nice 2-space cpp files
autocmd FileType cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell

" Get nice 4-space CMake files
autocmd FileType cmake setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab nospell

" Get nice 4-space XML files
autocmd FileType xml setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab nospell
