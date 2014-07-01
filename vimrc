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
" if has('mouse')
"   set mouse=a
"endif

"Tabs are eight columns wide. Each indentation level is one tab. (Popular with the Linux kernel.)
"set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab

"Tabs are four columns wide. Each indentation level is one tab. (Popular with Windows developers using Visual Studio.)
"set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

"Each indentation level is four spaces. Tabs are not used. (Popular with Java programmers.)
"set softtabstop=4 shiftwidth=4 expandtab

" Tabstops are 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
"set expandtab
set autoindent

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

au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>

"let g:syntastic_auto_loc_list=1

set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif
