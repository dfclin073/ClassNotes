set nocompatible        " must be first line

" Bobby Brooks .vimrc
" " Reference:
" " http://dougblack.io/words/a-good-vimrc.html
"
"
" " Key Mappings
" "{{{
" " F1 = 
" " F2 = 
" " F3 = 
" " F4 = 
" " F5 = Timestamp
" " F6 = Preformatted block of foldable text
" " F7 = New Target
" " F8 = 
" " F9 = Fold/Unfold
" " F10 = 
" " F11 = 
" " F12 = 
"
" "
" ------------------------------------------------------------------------------
"  " insert a timestamp with F5 & place cursor at title of block
  nmap <F5> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p -- ")<CR><Esc>
  imap <F5> <C-R>=strftime("%Y-%m-%d %a %I:%M %p -- ")<CR>
"
"  " insert a fold template with F6 - change this if the marker is changed
  nmap <F6> i<C-R>="\n# \n{{{\n\n\n}}}\n"<CR><Up><Up><Up><Up><Up><Right><Right><Esc>
  imap <F6> <C-R>="\n#  \n{{{\n\n\n}}}\n"<CR><Up><Up><Up><Up><Up><Right><Right>                          
"  " if you want to use a python script (this script needs changed for marker)
"  "nmap <F6> i<C-R>=system('/root/scripts/vimfolder.py')<CR><Esc>
"  "imap <F6> <C-R>=system('/root/scripts/vimfolder.py')<CR>
nmap <F7> i <C-R>="=================\n--\n=================\nX-----------------------------\n\n\n-----------------------------X"<CR><Up><Up><Up><Up><Up><Right><Right><Right><Space>
imap <F7> <C-R>="\n=================\n--\n=================\nX-----------------------------\n\n\n-----------------------------X"<CR><Up><Up><Up><Up><Up><Right><Right><Right><Space>

"
"  " Map F9 to fold/unfold [[[ CONFLICTS WITH CURRENT TMUX CONF ]]]
  inoremap <F9> <C-O>za
  nnoremap <F9> za
  onoremap <F9> <C-C>za
  vnoremap <F9> zf
"  "}}}
"
"
"  "Colors"
"  "{{{
"  colorscheme molokai     " set colorscheme for vim
  syntax enable           " enable syntax processing
"  "}}}
"
"  "Spaces & Tabs
"  "{{{
  set tabstop=4       " number of visual spaces per TAB
  set softtabstop=4   " number of spaces in tab when editing
  set expandtab       " tabs are spaces
"  "}}}
"
"  "UI Layout
"  "{{{

  set showcmd             " show command in bottom bar
  set cursorline          " highlight current line
  filetype indent on      " load filetype-specific indent files
  set wildmenu            " visual autocomplete for command menu
  set lazyredraw          " redraw only when we need to.
"  "}}}
"
"  "Searching
"  "{{{
  set ignorecase         " ignore case while searching
  set showmatch           " highlight matching [{()}]
  set incsearch           " search as characters are entered
  set hlsearch            " highlight matches
  set noerrorbells
  set novisualbell
  set t_vb=
  set tm=500
  " turn off search highlight
  nnoremap <leader><space> :nohlsearch<CR>
"  "}}}
"
"  "Folding
"  "{{{
  set foldenable          " enable folding
  set foldlevelstart=10   " open most folds by default
  set foldnestmax=10      " 10 nested fold max
  " space open/closes folds [[[ REMAPPED TO F9 ABOVE ]]]
  "nnoremap <space> za
  set foldmethod=marker " fold based on marker
  " Uncomment these to change the foldmarker to something other than the
"  curly braces
  set foldmarker=start,end
  set foldmarker=X------------------------,------------------------X
"  "}}}
"
"  "Backups
"  "{{{
  set backup
  set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
  set backupskip=/tmp/*,/private/tmp/*
  set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
  set writebackup
"  "}}}
"
"  "Line Shortcuts "{{{ "... "}}}
"  "Leader Shortcuts "{{{ "... "}}}
"  "Misc "{{{ "... "}}}
"  "Powerline "{{{ "... "}}}
"  "CtrlP "{{{ "... "}}}
"  "NERDTree "{{{ "... "}}}
"  "Syntastic "{{{ "... "}}}
"  "Launch Config "{{{ "... "}}}
"  "Tmux "{{{ "... "}}}
"  "MacVim "{{{ "... "}}}
"  "AutoGroups "{{{ "... "}}}
"  "Custom Functions "{{{ "... "}}}
"  "General {{{ "... "}}}
"  " vim:foldmethod=marker:foldlevel=0
