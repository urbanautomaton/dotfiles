set nocompatible

call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on
set exrc
set secure

" Core keymappings
:nore <Space> :
" Cycle through buffers using Ctrl-n and Ctrl-m for previous and next
:nnoremap <C-m> :bnext<CR>
:nnoremap <C-n> :bprev<CR>
" Cycle through tabs using Ctrl-j and Ctrl-k
:nnoremap <C-k> :tabnext<CR>
:nnoremap <C-j> :tabprev<CR>
" Window splitting
:map <C-/> :vs<CR>
:map <C-.> :sp<CR>
" JOOOOOOOOOOBBBBBBBSSSSS!!!!!
:imap § #
" File tree shortcuts
:imap <F4> <ESC>:NERDTreeToggle<CR>
:imap <F5> <ESC>:NERDTreeFind<CR>
:map <F4> :NERDTreeToggle<CR>
:map <F5> :NERDTreeFind<CR>
" Comment/uncomment blocks
:map \c :s/^/#/<CR>
:map \u :s/^#//<CR>
" Ctags
" Broken (because cword doesn't include !? in ruby) but possibly better
" if fixable?
":map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
:map <C-\> :vsp <CR><C-W><C-W><C-]>

" Command abbreviations
cabbrev te tabedit

" Editing and display variables
set bs=2          " minimal restrictions on backspace
set tabstop=2     " set tab character to 4 characters
set expandtab     " turn tabs into whitespace
set shiftwidth=2  " indent width for autoindent
set showtabline=2 " always show tab line
set laststatus=2  " always show status line
set visualbell    " turn off beeping
set showmatch     " show matching paren on entry
set number        " show line numbers
set ruler
if exists("&colorcolumn")
  set colorcolumn=80
endif
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ %cC\ (%p%%)]

" Colorschemes
colorscheme solarized
set background=dark
