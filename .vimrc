" ---------- plugin
if 0 | endif

if &compatible
 set nocompatible
endif

set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.cache/dein'))
call dein#add('Shougo/dein.vim')

call dein#add('tomasr/molokai')
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-jedi')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('itchyny/lightline.vim')
call dein#add('thinca/vim-quickrun')
call dein#add('rust-lang/rust.vim')
call dein#add('godlygeek/tabular')
call dein#add('plasticboy/vim-markdown')
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')
call dein#add('andviro/flake8-vim')

call dein#end()

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

let g:lightline = {
\ 'colorscheme': 'wombat',
\ }
let g:quickrun_config = {
\   '_' : {
\     'outputter/buffer/split' : ':botright 8sp',
\     'outputter/buffer/close_on_empty' : 1,
\     'hook/time/enable' : 1,
\     'runner' : 'vimproc',
\     'runner/vimproc/updatetime' : 60
\   },
\ }
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

let g:vim_markdown_folding_disabled = 1

augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" deoplete.vim requires python3
let g:python3_host_prog = '/usr/local/bin/python3'
let g:deoplete#enable_at_startup = 1

" ---------- appearance & setting
set t_Co=256
set laststatus=2                    " Show status line (for vim-powerline)
set imdisable
set tabstop=2                       " 1 tab = 2 spaces
set shiftwidth=2                    " When automatic indent occured, shift 2 spaces.
set number                          " appear row number
set whichwrap=b,s,h,l,<,>,[,]       " don't stop cursor at head/tail of row
set cursorline                      " cursor line highlight
set visualbell t_vb=                " disable beep sound
set spelllang=en,cjk
set clipboard=unnamed
set backspace=indent,eol,start
set wildmenu
set incsearch
set hlsearch

augroup vimrc
  autocmd!

  " replace from tab to spaces (save-time)
  " In case of Makefile or markdown, it should use exactly tab
  let whitespace_blacklist = ['make', 'markdown', 'addp-hunk-edit.diff']
  autocmd BufWritePre * if index(whitespace_blacklist, &ft) < 0 | :%s/\s\+$//ge " delete extra spaces at tail of rows (save-time)
  autocmd BufWritePre * if index(whitespace_blacklist, &ft) < 0 | :%s/\t/  /ge

  autocmd ColorScheme * hi Normal ctermfg=grey ctermbg=black
  autocmd ColorScheme * hi CursorLine cterm=underline ctermfg=none ctermbg=none

  " enable spell checker only for document files
  autocmd BufNewFile,BufRead *.tex set spell
  autocmd BufNewFile,BufRead *.md set spell
augroup END

noremap ; :
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

syntax enable
colorscheme molokai
