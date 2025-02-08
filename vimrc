" ~/.vimrc



" Vim plugin management with vim-plug
"
" On vim startup, if you get errors like these:
"   Unknown function: plug#begin
"   Not an editor command: Plug [...]
" it could mean that ~/.vim/autoload/plug.vim does not exist, so install it with:
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" How to use vim-plug:
"   :PlugInstall to install the plugins
"   :PlugUpdate  to install or update the plugins
"   :PlugDiff    to review the changes from the last update
"   :PlugClean   to remove plugins no longer in the list
"
" By default, the plugins are installed as directories inside ~/.vim/plugged.
"
" See also https://github.com/junegunn/vim-plug/blob/master/README.md
"
call plug#begin()

Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" Switch from syntastic to ALE
" Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'dense-analysis/ale'
" Plug 'https://github.com/nvie/vim-flake8'

" Next line automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()


" Configure the plugins

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" nerdtree
" Start NERDTree when Vim is started without file arguments or when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | execute 'NERDTree' | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
  \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }

" vim-flake8
" autocmd BufWritePost *.py call Flake8()
" let g:flake8_show_in_gutter = 1
" let g:syntastic_python_checkers = ['flake8']

" ale
"
" Documentation: https://github.com/dense-analysis/ale/blob/master/doc/ale.txt
" enable ale
let g:ale_enabled = 1
" always show warning/error messages for all lines
let g:ale_virtualtext_cursor = 2
" always display the sign column, even if no warnings/errors
let g:ale_sign_column_always = 1
" echo the warning/error message under cursor
let g:ale_echo_cursor = 1
" the linters need to be installed on the system
let g:ale_linters = {
\   'c': ['gcc', 'clang', 'clangtidy'],
\}
let g:ale_fixers = {
\   'c': ['clang-format'],
\}
" let clang-tidy auto detect the .clang-tidy file
let g:ale_c_clangtidy_options = ''
" make ale read the compile_commands.json file in the build directory
let g:ale_c_parse_compile_commands = 1
let g:ale_c_compile_commands_directory = 'build'
" automatically fix files on save
let g:ale_fix_on_save = 1




" Disable compatibility with vi, use vim enhancements
set nocompatible

" Enable modeline, search the first and last 5 lines
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

" Display a vertical line at column 80
set colorcolumn=80

" Highlight all search matches, turn off highlight with :noh
set hlsearch

" Do incremental searching
set incsearch

" Perform case insensitive searching
set ignorecase

" Typing small case will search case insensitive
" Typing mixed case will search exact case
set smartcase

" Hide buffers instead of closing them
" Open a new buffer without writing changes to current buffer
set hidden

" Disable background color erase
" Vim extends the color scheme's background color to the whole terminal screen
set t_ut=

" Enable 256 colors in vim
set t_Co=256

" Unsure what this does
set t_Cs=

" Set the width of a TAB to 8 spaces, but still it is a \t
set tabstop=8

" Do not expand a tab to spaces
set noexpandtab

" Indentation will have a width of 8
set shiftwidth=8

" Vim will use 8 columns when hitting tab in insert mode
set softtabstop=8

" Automatically wrap text without exceeding the 79 characters limit
set textwidth=80

" Put a dollar sign up to the point of editing when using the c command
set cpoptions+=$

" Disable mouse support
set mouse=

" Disable beeping (aka "bell") and window flashing
set noerrorbells visualbell t_vb=

" Do not maintain a history file of all the directories that were modified
let g:netrw_dirhistmax = 0

" Enable spell checking
set spelllang=en_us,el
set spellfile=~/.vim/spell/en.utf-8.add
set spell

" Settings for folding
"
" Fold based on indent
" set foldmethod=indent
" Do not fold by default
" set nofoldenable
" The number of | or numbers displayed
" set foldcolumn=1
" The deepest fold is 10 levels
" set foldnestmax=10
set foldmethod=manual



" Colors

" Highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinLeave * call clearmatches()

" Set the Normal group background terminal color to none
" so that vim has the same transparency as xterm
highlight Normal ctermbg=none

" Set the color scheme
set background=light
let g:solarized_termcolors=256
" colorscheme mustang
" colorscheme xoria256
" colorscheme mustang
" colorscheme monokai
colorscheme solarized



" Python
" Do not auto indent the line when a colon is inserted
" http://stackoverflow.com/questions/19320747/prevent-vim-from-indenting-line-when-typing-a-colon-in-python
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:

" HTML
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab shiftwidth=2 softtabstop=2 textwidth=0 colorcolumn=0

" YAML
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell
" Do not auto indent the line when a # is inserted
autocmd FileType yaml setlocal indentkeys-=0#

" Shell
autocmd FileType sh setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab nospell

" Javascript
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell

" Java
autocmd FileType java setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell

" Groovy
autocmd FileType groovy setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell

" C
autocmd FileType c setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell

" C++
autocmd FileType cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell

" CMake
autocmd FileType cmake setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab nospell

" XML
autocmd FileType xml setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab nospell

" ASTRA
autocmd BufNewFile,BufRead *.astra set filetype=astra
autocmd FileType astra setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab nospell
