set nocompatible

:map ;f :%s/[ ]*\|[ ]*/\t/g<ENTER>

set tabstop=2 "set tab character to 4 characters
set expandtab "turn tabs into whitespace
set shiftwidth=2 "indent width for autoindent


set nocompatible
syntax on
filetype plugin indent on


set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
"set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

set laststatus=2
set visualbell " Turn off beeping


colorscheme vividchalk
set t_Co=256
syntax enable

:map \c :s/^/#/<CR>
:map \u :s/^#//<CR>

:map ;e :!ruby %<CR>
:map ;p :!php %<CR>
:map ;c '<,'>s/^/# /g

" Run a git blame on the lines selected in visual mode to find out who made
" the changes
:vmap gl :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p<CR>
" And the same for subversion
:vmap sgl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p<CR>


:map gm :e app/models
:map gv :e app/views
:map gc :e app/controllers

:imap § #

" Cycle through buffers using Ctrl-m and Ctrl-n for previous and next
:nnoremap <C-m> :bnext<CR>
:nnoremap <C-n> :bprev<CR>

set guioptions-=T  " don't need toolbar
set backupdir=~/tmp " Don't annoy me with swap files in working directory



:map \vrc :source $MYVIMRC<CR>
:map \evrc :e $MYVIMRC<CR>

" lots of useful ruby/rails shortcuts
:map \step :e features/step_definitions<CR>
:map \feat :e features<CR>
:map \app :e app<CR>
:map \view :e views<CR>
:map \cont :e controllers<CR>
:map \rout :e config/routes.rb<CR>
:map \fact :e test/factories.rb<CR>
:map \tr :e config/locales/strings.en_GB.yml<CR>
:map \gita :%s/.*modified:   /git add /g<CR>
:imap cplc  "([^\"]*)"

fun! Lookup(some_term)
  exe 'grep -rin "'.a:some_term.'" config/locales/strings.en_GB.yml'
endfun

au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim

if has("gui_running")
  set guioptions=aiA " Disable toolbar, menu bar, scroll bars
endif " has("gui_running")

:map h1 yyp:s/./=/g<ENTER>
:map h2 yyp:s/./-/g<ENTER>
:map <C-'> :sp<ENTER>
:map <C-\> :vs<ENTER>

:nnoremap <C-m> :bnext<CR>
:nnoremap <C-n> :bprev<CR>

" Automatically remove all trailing whitespace from lines so I don't break our
" test suite
autocmd BufWritePre *.rb :%s/\s\+$//e

set showmatch




" Attempt at folding yaml
" set foldmethod=indent
" setlocal foldmethod=expr
"setlocal foldexpr=(getline(v:lnum)=~'^$')?-1:((indent(v:lnum)<indent(v:lnum+1))?('>'.indent(v:lnum+1)):indent(v:lnum))
"set foldtext=getline(v:foldstart)
"set fillchars=fold:\ "(there's a space after that \)
" highlight Folded ctermfg=DarkGreen ctermbg=Black
"
"

" Borrowed from kerryb's vimrc:
" http://github.com/kerryb/vim-config/blob/master/vimrc

function! OpenInBrowser(url)
  if has("mac")
    exec '!open '.a:url
  else
    exec '!firefox -new-tab '.a:url.' &'
  endif
endfunction

" Open the Ruby ApiDock page for the word under cursor
function! OpenRubyDoc(keyword)
  let url = 'http://apidock.com/ruby/'.a:keyword
  call OpenInBrowser(url)
endfunction
noremap RB :call OpenRubyDoc(expand('<cword>'))<CR>

" Open the Rails ApiDock page for the word under cursor
function! OpenRailsDoc(keyword)
  let url = 'http://apidock.com/rails/'.a:keyword
  call OpenInBrowser(url)
endfunction
noremap RR :call OpenRailsDoc(expand('<cword>'))<CR>

" :SudoW to save file using sudo (must be already authorised, eg sudo -v)
command! -bar -nargs=0 SudoW :sile

