set nocompatible

let g:pathogen_disabled = []
let g:slime_target = "tmux"
let g:syntastic_tex_checkers = ['lacheck']
let g:syntastic_eruby_checkers = []

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
set directory=~/.vim/backups//
set backupdir=~/.vim/swap//
set undodir=~/.vim/undo//
set hlsearch
set synmaxcol=256
set formatoptions+=j " remove comment leader when joining comment lines
set textwidth=78     " because we're not savages

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" If we're in tmux, use this nifty hack to change cursor shape in
" insert mode
if !empty($TMUX)
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif

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
set shiftround " always shift by multiple of shiftwidth (e.g. >>, <<)

if &history < 1000
  set history=1000
endif
set viminfo^=!

if exists("&colorcolumn")
  set colorcolumn=80
endif
if exists('*fugitive#statusline')
  set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ %cC\ (%p%%)]\ %{fugitive#statusline()}
else
  set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ %cC\ (%p%%)]
endif

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

" Word processor mode
func! WordProcessorMode()
  map j gj
  map k gk
  map $ g$
  map ^ g^
  setlocal formatoptions+=n
  setlocal textwidth=72
  setlocal complete+=s
  setlocal formatlistpat=^\\s*[0-9*-]\\+[\\]:.)}\\t\ ]\\s*
  setlocal wrap
  setlocal linebreak
endfu
com! WP call WordProcessorMode()
augroup wordprocessormode
  autocmd!
  autocmd BufNewFile,BufRead *.{markdown,md} call WordProcessorMode()
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']
augroup END

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
" Tab-complete without c-p/c-n
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" Ctags
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

" unimpaired.vim style nav for preview-window tags
nnoremap ]g :ptnext<CR>
nnoremap [g :ptprevious<CR>
nnoremap ]G :ptlast<CR>
nnoremap [G :ptfirst<CR>

" Tabularize mappings
func! SetTabularizeMappings()
  " Tabularize assignments
  " Uses zero-width negative lookahead to prevent splitting up hashrockets:
  nmap <Leader>a= :Tabularize /=\@<!=[\=>]\@!<CR>
  vmap <Leader>a= :Tabularize /=\@<!=[\=>]\@!<CR>
  " Tabularize argument lists
  nmap <Leader>a, :Tabularize /,\zs/l1r0<CR>
  vmap <Leader>a, :Tabularize /,\zs/l1r0<CR>
  " Tabularize JS style object definitions
  " Exclude ':' char from match to prevent colons being columnized:
  nmap <Leader>a: :Tabularize /:\zs/l1r0<CR>
  vmap <Leader>a: :Tabularize /:\zs/l1r0<CR>
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
augroup tabularizemappings
  autocmd!
  autocmd VimEnter * if exists(":Tabularize") | exe "call SetTabularizeMappings()" | endif
augroup END

" Command abbreviations
cabbrev te tabedit
" use %% as a shorthand for 'the directory of the current file'
cabbrev <expr> %% expand('%:p:h').'/'
map <leader>e :edit %%
map <leader>v :view %%

" Run a shell command and put its output in a quickfix buffer
let g:command_output=".quickfix.tmp"
function! s:RunShellCommandToQuickfix(cmdline)
  execute '!'.a:cmdline.' | tee '.g:command_output
endfunction
command! -nargs=+ -complete=command ToQF call s:RunShellCommandToQuickfix(<q-args>)

" Testing!
nnoremap <F6> :execute "Dispatch ".b:dispatch.":".line(".")<CR>
nnoremap <F7> :execute "Focus ".b:dispatch<CR>
nnoremap <F8> :Focus!<CR>
nnoremap <F9> :Dispatch<CR>
augroup dispatchsetup
  autocmd!
  autocmd BufNewFile,BufRead *_spec.rb let b:dispatch = 'rspec %'
  autocmd BufNewFile,BufRead *_test.rb let b:dispatch = 'testrb %'
  autocmd FileType cucumber let b:dispatch = 'cucumber %'
  autocmd BufNewFile,BufRead *_spec.js let b:dispatch = 'jasmine-node %'
augroup END

" I'm not 100% sure why this needs doing tbh.
augroup shellsetup
  autocmd!
  autocmd Filetype sh setlocal formatoptions-=t formatoptions+=croql
augroup END

augroup typescriptsetup
  autocmd!
  let g:typescript_compiler_options = '--noEmit --module "commonjs"'
  autocmd Filetype typescript setlocal noexpandtab
  autocmd FileType typescript call FourTab()
augroup END

func! FourTab()
  setlocal tabstop=4 shiftwidth=4
endfunc

augroup phptabsettings
  autocmd!
  autocmd FileType php call FourTab()
augroup END

augroup gotabsettings
  autocmd!
  autocmd Filetype go setlocal noexpandtab
  autocmd FileType go call FourTab()
augroup END

" Clojure
augroup clojuresettings
  autocmd!
  autocmd BufNewFile,BufRead *.clj RainbowParenthesesToggle
  autocmd BufNewFile,BufRead *.cljs RainbowParenthesesToggle
augroup END
" Connect to a phantomjs-backed clojurescript repl
command! Piggie :Piggieback (cemerick.austin/exec-env)
" Connect to a chrome-backed clojurescript browser repl
command! Biggie :Piggieback (cemerick.austin/exec-env :exec-cmds ["open" "-ga" "/Applications/Google Chrome.app"])

" Fugitive stuff
" Clean up fugitive buffers after they're closed
augroup fugitivebufferhandling
  autocmd!
  autocmd BufReadPost fugitive://*
    \ set bufhidden=delete
  " Use '..' to navigate up git trees
  autocmd User fugitive
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif
augroup END

" git grep for the current cursor word
nnoremap gr :Ggrep <cword><CR><CR>:copen<CR><CR>
