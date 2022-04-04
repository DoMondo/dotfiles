set nocompatible              " be iMproved, required
filetype off                  " required
set shell=/bin/bash

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'rhysd/vim-clang-format'
Plugin 'morhetz/gruvbox'
Plugin 'sheerun/vim-wombat-scheme'
Plugin 'nblock/vim-dokuwiki'
Plugin 'scrooloose/nerdcommenter'
Plugin 'petRUShka/vim-opencl'
Plugin 'godlygeek/csapprox'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tell-k/vim-autopep8' 
Plugin 'kopischke/vim-fetch'
Plugin 'vim-scripts/vimgdb'
Plugin 'keith/swift.vim'
Plugin 'tikhomirov/vim-glsl'
Plugin 'matze/vim-meson'
Plugin 'peterhoeg/vim-qml'
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
call vundle#end()            " required
"filetype plugin indent on    " required
" Nerdcommenter
filetype plugin on
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
if v:progname =~? "evim"
  finish
endif
set encoding=utf-8
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set t_Co=256

" Use the linux clipboard (I tend to use vim across consoles)
set clipboard=unnamedplus
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup        " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
  set backupdir=~/.vim/backup,/tmp
  set directory=~/.vim/swapfiles,/tmp
endif
set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set cursorline	    " highlight current line
set number		    " show line numbers all the time
" set relativenumber  " show relative numbers; useful in normal mode
set expandtab       " use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.
set smarttab        " when on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.
set shiftwidth=3
set tabstop=3
set scrolloff=5
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
set ignorecase      " ignore case in search patterns.
set smartcase       " override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
" Don't wait to go normal
set timeoutlen=1000 ttimeoutlen=0
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq
" Add line break below without entering insert mode

nmap <Enter> i<ENTER><Esc>
" Be careful with this one, console-dependant
nmap OM o<Esc>
let mapleader=' '
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :q!<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>X :x!<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>W :w!<CR>
nnoremap <Leader>n :nohl<CR>
nnoremap <Leader>l :exec &rnu? "se nornu!" : "se rnu!"<CR>
function CallFormatter()
    if (&ft=='python')
       " Save linenumber
       :let lineNumber=line('.')
       ":Autopep8
       :0,$!yapf --style="$HOME/.config/yapf/.style.yapf"
       ":normal gg
       :execute "normal!".lineNumber."gg"
    elseif (&ft=='tex')
       :0,$!latexindentvim
    else
       :ClangFormat
   endif
   :normal zz
endfunction
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79
"let g:autopep8_aggressive=2
autocmd FileType python set equalprg=autopep8\ -
"map <C-f> :ClangFormat<CR>
map <C-f> :call CallFormatter()<CR>

" NERDTreeP
map <Leader>t :NERDTreeToggle<CR>

" Move to word
map  <Leader>f <Plug>(easymotion-bd-w)
"nmap <Leader>f <Plug>(easymotion-overwin-w)

" Git blame
map <Leader>b :Git blame<CR>
" Git log for a file
"map <Leader>g :Glog<CR>

" Move to word
"map  <Leader>w <Plug>(easymotion-bd-w)
"nmap <Leader>w <Plug>(easymotion-overwin-w)

" Draw airline glyphs
let g:airline_powerline_fonts = 1
" Set Airline theme (https://github.com/vim-airline/vim-airline/wiki/Screenshots)
let g:airline_theme='minimalist_domondo'

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

set laststatus=2
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set background=dark
  " let g:solarized_termcolors=256
  colorscheme wombat_oscar
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  autocmd FileType tex setlocal textwidth=83
  autocmd FileType dokuwiki setlocal textwidth=83
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  au FileType python          setlocal omnifunc=python3complete#Complete
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

"cursor shape (for kitty)
let &t_SI = "\033[5 q" " Line cursor
let &t_SR = "\033[5 q" " Line cursor
let &t_EI = "\033[1 q" " Block cursor
let g:vundle_default_git_proto = 'https'
"autocmd BufNewFile,BufRead *.cl   set syntax=cl
au! BufRead,BufNewFile *.strace set filetype=strace

" Highlight variables
let g:no_highlight_group_for_current_word=["Statement", "Comment", "Type", "PreProc"]
function s:HighlightWordUnderCursor()
    let l:syntaxgroup = synIDattr(synIDtrans(synID(line("."), stridx(getline("."), expand('<cword>')) + 1, 1)), "name")

    if (index(g:no_highlight_group_for_current_word, l:syntaxgroup) == -1)
        exe printf('match Occurrence /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    else
        exe 'match Occurrence /\V\<\>/'
    endif
endfunction

autocmd CursorMoved * call s:HighlightWordUnderCursor()
let g:ycm_confirm_extra_conf = 0
let g:ycm_server_python_interpreter = '/usr/bin/python'
" Don't show YCM errors
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_echo_current_diagnostic = 0
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 1

let g:NERDCustomDelimiters = {
         \ 'opencl' : { 'left' : '//', 'leftAlt': '/*', 'rightAlt': '*/'}
         \ }

set completeopt-=preview
"let g:SuperTabClosePreviewOnPopupClose = 1
let g:ycm_autoclose_preview_window_after_insertion = 1 
let g:ycm_autoclose_preview_window_after_completion = 1

let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
let g:gitgutter_map_keys = 0
map <Leader>g :GitGutterToggle<CR>
let g:ycm_add_preview_to_completeopt = 0
set viminfo='100,f1

if !exists('g:airline_symbols')
 let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
" Don't show git info
let g:airline_extensions = []
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0700)
endif

" tell it to use an undo file
set undofile
" set a directory to store the undo history
set undodir=~/.vim/undo/
" Deactivate man search
map <S-K> <Nop>
"map <Leader>1 :make -C .. <CR> :cw <CR>
map <Leader>1 :make <CR> :cw <CR>
map <Leader>2 :cp<CR>
map <Leader>3 :cn<CR>
map <Leader>4 :cl<CR>

