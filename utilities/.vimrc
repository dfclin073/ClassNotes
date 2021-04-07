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
" " F6 = New Target 
" " F7 = New Fold Block
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

nmap <F6> i <C-R>="=================\n--\n=================\nX-----------------------------\n\n\n-----------------------------X"<CR><Up><Up><Up><Up><Up><Right><Right><Right><Space>
imap <F6> <C-R>="\n=================\n--\n=================\nX-----------------------------\n\n\n-----------------------------X"<CR><Up><Up><Up><Up><Up><Right><Right><Right><Space>

nmap <F7> i <C-R>="X------------------------------\n\n\n-------------------------------X"<CR><UP><UP>
imap <F7> <C-R>="X------------------------------\n\n\n-------------------------------X"<CR><UP><UP>

nmap <F8> i <C-R>="user:\npass:\nport:"<CR><UP><UP>
imap <F8> <C-R>="user:\npass:\nport:"<CR><UP><UP>


"
  inoremap <F10> <C-O>za
  nnoremap <F10> za
  onoremap <F10> <C-C>za
  vnoremap <F10> zf

nmap <F9> i <C-R>="scan:\npayload:\nexploit:\nprivesc:"<CR><UP><UP><UP>
imap <F9> <C-R>="scan:\npayload:\nexploit:\nprivesc:"<CR><UP><UP><UP>
  
  
"  "Colors"
  
  colorscheme elflord
  syntax enable           " enable syntax processing
" syntax match IP  /[0-9]\{1,3}\([.][0-9]\{1,3}\)\{3\}/
syntax match IP "[0-9]\{1,3}\([.][0-9]\{1,3}\)\{3\}:\d\{1,5}\|[0-9]\{1,3}\([.][0-9]\{1,3}\)\{3\} \d\{1,5}\|[0-9]\{1,3}\([.][0-9]\{1,3}\)\{3\}" contains=port

highlight IP ctermfg=82
  
syntax match potionComment "\v#.*$"
highlight potionComment ctermfg=014

syntax region Comments start="\(^\zs\/\/\|\s\{1,4}\zs\/\/\)" end="\ze$"
highlight Comments ctermfg=014

syntax match nBracketVariable "<[a-zA-Z_][a-zA-Z_0-9]*>"             
highlight nBracketVariable ctermfg=005

autocmd BufRead * setlocal foldmethod=marker
autocmd BufRead * normal zM

syntax match port "[0-9]\{1,3}\([.][0-9]\{1,3}\)\{3}\( \|:\)\zs\d\{1,5}\ze"
"syntax match port "\zs\d\{1,5}\ze/"
highlight port ctermfg=202

syntax match portfield /port: \zs\d\{1,5}\ze/
highlight portfield ctermfg=202

syntax match portswitch /-p \zs\d\{1,5}\ze/
highlight portswitch ctermfg=202

syntax match socket "\/tmp\/\S*\.ssh" contains=nBracketVariable
highlight socket ctermfg=196 


syntax region nTimestamp start="^\d\d\d\d-\d\d-\d\d \w\w\w \d\d:\d\d \w\w" end="--"
highlight nTimestamp ctermfg=34

syntax region Alert start="^!!" end="$"
highlight Alert ctermfg=white ctermbg=196

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
