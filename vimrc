" .vimrc


" use vim enhancements over old vi compatibility
set nocompatible

" enable modelines
" search the first and last 5 lines
set modeline
set modelines=5

" set the status line the way Derek Wyatt likes it
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" always display the status line
set laststatus=2

" show the current mode (Insert, Replace, Visual) on the last line
set showmode

" show (partial) command in the last line of the screen
set showcmd

" keep 50 lines of command line history
set history=50

" show current column and row position
set ruler

" display line numbers
set number

" enable syntax highlighting
syntax on

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" display a line at column 80
set colorcolumn=80

" highlight all search matches
" (turn off highlight with :noh)
set hlsearch

" do incremental searching
set incsearch

set ignorecase

" type small case will search case independent, type mixed case will use exact
set smartcase

" hide buffers instead of closing them
" can open a new buffer without writing changes to current buffer
set hidden

" disable Background Color Erase
" Vim extends the color scheme's background color to the whole terminal screen
set t_ut=

" enable 256 colors in vim
" put this your .vimrc before setting the colorscheme
set t_Co=256

" the width of a TAB is set to 8. Still it is a \t. It is just that Vim will
" interpret it to be having a width of 8
set tabstop=8

" don't expand tab to spaces
set noexpandtab

" indentation will have a width of 8
set shiftwidth=8

" how many columns when hitting tab in insert mode
set softtabstop=8

" this will automatically wrap text as close to 79 characters as white space
" allows without exceeding the 79 character limit
set textwidth=80

" put a dollar sign up to the point of editing when using c
set cpoptions+=$

" enable mouse support
set mouse=a

" disable beeping (aka "bell") and window flashing
set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

" set the colorscheme
"set background=dark
let g:solarized_termcolors=256
colorscheme solarized
colorscheme xoria256
colorscheme monokai

" highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" enable spell checking
set spell

" enable ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Do not auto indent the line when I insert a colon
" http://stackoverflow.com/questions/19320747/prevent-vim-from-indenting-line-when-typing-a-colon-in-python
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:

" Enable Tim Popes' pathogen
execute pathogen#infect()

" Syntastic's recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

" Enable spell checking
set spelllang=en_us,el
set spellfile=~/.vim/spell/en.utf-8.add " FIXME: A better path for this?
set spell

" Run flake8 inside vim
" https://github.com/nvie/vim-flake8
autocmd BufWritePost *.py call Flake8()
let g:flake8_show_in_gutter = 1
