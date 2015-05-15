execute pathogen#infect()
syntax on
filetype plugin indent on

set t_ut=
set t_Co=256

set nobackup
set nu

" keep 50 lines of command line history
set history=50

" show the cursor position all the time
set ruler

set hlsearch

" do incremental searching
set incsearch

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"	set mouse=a
"endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
	" Use filetype detection and file-based automatic indenting.
	filetype plugin indent on

	" Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

" For everything else, use a tab width of 8 space chars.
set tabstop=8 " The width of a TAB is set to 8.
              " Still it is a \t. It is just that
              " Vim will interpret it to be having
              " a width of 8.
set shiftwidth=8 " Indents will have a width of 8.
set softtabstop=8 " Sets the number of columns for a TAB.
set noexpandtab
"set textwidth=80

"Put a dollar sign up to the point of editing when using c
set cpoptions+=$

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Show (partial) command in the last line of the screen
set showcmd

" Show the current mode
set showmode

" Set the status line the way derek wyatt likes it
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

set hidden

if has('gui_running')
    set guifont=Monospace\ 12
    set guioptions=aegimLt
    set printoptions=paper:letter
    syntax enable
    set background=light
    colorscheme solarized
else
    set background=dark
    syntax enable
    let g:solarized_termcolors=256
    colorscheme solarized
endif

"au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
"au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
"au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>

"let g:syntastic_auto_loc_list=1

set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif
