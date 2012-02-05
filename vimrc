set nocompatible

:map ;f :%s/[ ]*\|[ ]*/\t/g<ENTER>

set tabstop=2 "set tab character to 4 characters
set expandtab "turn tabs into whitespace
set shiftwidth=2 "indent width for autoindent

" Enable local-directory .vimrc files, but disallow unsafe commands
set exrc
set secure

set nocompatible
syntax on
filetype plugin indent on

set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ %cC\ (%p%%)]
"set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

set laststatus=2
set visualbell " Turn off beeping

:nore <Space> :

"set t_Co=256
syntax enable
"let g:solarized_termcolors=256
colorscheme solarized
set background=dark

cabbrev te tabedit

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

:imap § #

" File tree shortcut
:imap <F4> <ESC>:NERDTreeToggle<CR>
:imap <F5> <ESC>:NERDTreeFind<CR>
:map <F4> :NERDTreeToggle<CR>
:map <F5> :NERDTreeFind<CR>

" Ctags gubbins
" Broken (because cword doesn't include !? in ruby) but possibly better
" if fixable?
"map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
:map <C-\> :vsp <CR><C-W><C-W><C-]>

" Cycle through buffers using Ctrl-m and Ctrl-n for previous and next
:nnoremap <C-m> :bnext<CR>
:nnoremap <C-n> :bprev<CR>

" Cycle through tabs using Ctrl-h and Ctrl-l
:nnoremap <C-k> :tabnext<CR>
:nnoremap <C-j> :tabprev<CR>

" Window splitting
:map <C-/> :vs<CR>
:map <C-.> :sp<CR>

au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim

:nnoremap <C-m> :bnext<CR>
:nnoremap <C-n> :bprev<CR>

set showtabline=2

set showmatch
set number
if exists("&colorcolumn")
  set colorcolumn=80
endif

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
