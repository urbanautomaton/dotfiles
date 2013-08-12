set nocompatible

let g:pathogen_disabled = []
let g:slime_target = "tmux"

set rtp+=~/.vim/bundle/powerline.vim/powerline/bindings/vim

call pathogen#infect()
call pathogen#helptags()
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set exrc
set secure
set magic

" Editing and display variables
set backspace=indent,eol,start
set tabstop=2     " set tab character to 2 characters
set expandtab     " turn tabs into whitespace
set smarttab
set complete-=i
set autoindent
set shiftwidth=2  " indent width for autoindent
set showtabline=2 " always show tab line
set laststatus=2  " always show status line
set splitright    " split panes appear on the right
set splitbelow    " guess
set visualbell    " turn off beeping
set showmatch     " show matching paren on entry
set number        " show line numbers
set wildmenu
set ruler
set showcmd       " show last command
set directory=~/.vim/backups
set backupdir=~/.vim/backups

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
end
set display+=lastline

set autoread
set autowrite
set fileformats+=mac

set nrformats-=octal
set shiftround

if &history < 1000
  set history=1000
endif
set viminfo^=!

if exists("&colorcolumn")
  set colorcolumn=80
endif
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ %cC\ (%p%%)]\ %{fugitive#statusline()}

set ttimeout
set ttimeoutlen=50

" Colorschemes
colorscheme solarized
set background=dark

if !exists('g:netrw_list_hide')
  let g:netrw_list_hide = '^\.,\~$,^tags$,^.ctags$'
endif

if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

function! OpenWithSpecs(...)
	let l:file_globs=a:000
  for glob in file_globs
    for filename in split(glob(glob), "\n")
      let l:specname = 
            \ substitute(filename, "^app/\\(.*\\).rb$", "spec/\\1_spec.rb", "")
      exec 'tabedit '.specname
      exec 'rightbelow vsplit '.filename
    endfor
  endfor
endfunction

function! OpenSpecFor(filename)
  let l:filename=a:filename
  let l:specname = 
        \ substitute(filename, "^app/\\(.*\\).rb$", "spec/\\1_spec.rb", "")
  exec 'leftbelow vsplit '.specname
endfunction

command! -complete=file -nargs=+ SpecEdit call OpenWithSpecs(<f-args>)
cabbrev spe SpecEdit

" Word processor mode
func! WordProcessorMode()
  map j gj
  map k gk
  map $ g$
  map ^ g^
  setlocal textwidth=72
  setlocal formatexpr=autofmt#uax14#formatexpr()
  set complete+=s
  " set formatprg=PARINIT=72rTbgqR\\\ P=-\\\ B=.,\\?_A_a\\\ Q=_s\\>\\\\|\ par
  setlocal wrap
  setlocal linebreak
endfu
com! WP call WordProcessorMode()
autocmd BufNewFile,BufRead *.{markdown,md} call WordProcessorMode()

" Core keymappings
nnoremap Y y$
nore <Space> :
" Cycle through buffers using Ctrl-n and Ctrl-m for previous and next
nnoremap <C-m> :bnext<CR>
nnoremap <C-n> :bprev<CR>
" Cycle through tabs using Ctrl-j and Ctrl-k
nnoremap <C-k> :tabnext<CR>
nnoremap <C-j> :tabprev<CR>
" JOOOOOOOOOOBBBBBBBSSSSS!!!!!
imap § #
" Comment/uncomment blocks
map \c :s/^/#/<CR>
map \u :s/^#//<CR>
" Save with sudo:
cmap w!! %!sudo tee > /dev/null %

" Ctags
set tags=./.ctags,.ctags,./tags,tags
map <F4> :TagbarToggle<CR>
imap <F4> <ESC>:TagbarToggle<CR>
" Broken (because cword doesn't include !? in ruby) but possibly better
" if fixable?
":map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
:map <C-\> :rightbelow vsp <CR><C-]>
" Paste mode toggle
nnoremap <F5> :set invpaste paste?<Enter>
imap <F5> <C-O><F5>
set pastetoggle=<F5>

" Tabularize mappings
func! SetTabularizeMappings()
  " Tabularize assignments
  " Uses zero-width negative lookahead to prevent splitting up hashrockets:
  nmap <Leader>a= :Tabularize /=\@<!=[\=>]\@!<CR>
  vmap <Leader>a= :Tabularize /=\@<!=[\=>]\@!<CR>
  " Tabularize argument lists
  nmap <Leader>a, :Tabularize /,\zs<CR>
  vmap <Leader>a, :Tabularize /,\zs<CR>
  " Tabularize JS style object definitions
  " Exclude ':' char from match to prevent colons being columnized:
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  " Tabularize hashrockets
  nmap <Leader>ah :Tabularize /=><CR>
  vmap <Leader>ah :Tabularize /=><CR>
  " Tabularize hash arguments
  nmap <Leader>ar :Tabularize /:[^,]\{-1,}=><CR>
  vmap <Leader>ar :Tabularize /:[^,]\{-1,}=><CR>
  " Align block delimiters
  nmap <Leader>ab :Tabularize /\(^[^{]*\zs{\\|}$\)<CR>
  vmap <Leader>ab :Tabularize /\(^[^{]*\zs{\\|}$\)<CR>
endfu
autocmd VimEnter * if exists(":Tabularize") | exe "call SetTabularizeMappings()" | endif

" Command abbreviations
cabbrev te tabedit

" Run a shell command and put its output in a quickfix buffer
let g:command_output=".quickfix.tmp"
function! s:RunShellCommandToQuickfix(cmdline)
  execute '!'.a:cmdline.' | tee '.g:command_output
endfunction
command! -nargs=+ -complete=command ToQF call s:RunShellCommandToQuickfix(<q-args>)

" Testing!
nnoremap <F9> :Dispatch<CR>
autocmd BufNewFile,BufRead *_spec.rb let b:dispatch = 'rspec %'
autocmd FileType cucumber let b:dispatch = 'cucumber %'
autocmd BufNewFile,BufRead *_spec.js let b:dispatch = 'jasmine-node %'

" Fugitive stuff
autocmd BufReadPost fugitive://*
  \ set bufhidden=delete
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
