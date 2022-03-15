set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-abolish'
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'nelstrom/vim-markdown-folding'
Plug 'tmhedberg/matchit'
Plug 'powerline/powerline'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'danchoi/ri.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'altercation/vim-colors-solarized'
Plug 'w0rp/ale'
Plug 'kien/rainbow_parentheses.vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'aklt/plantuml-syntax'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fireplace'
Plug 'hashivim/vim-terraform'
Plug 'jxnblk/vim-mdx-js'
call plug#end()

let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = 1
let g:ale_linters = {
      \ 'json': [],
      \ 'javascript': ['eslint'],
      \ 'tex': ['lacheck'],
      \ }
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'html': ['prettier'],
      \ 'javascript': ['prettier'],
      \ 'javascript.*': ['prettier'],
      \ 'json': ['prettier'],
      \ 'css': ['prettier'],
      \ 'scss': ['prettier'],
      \ 'rust': ['rustfmt'],
      \ 'terraform': ['terraform'],
      \ 'typescript': ['prettier'],
      \ 'typescript.tsx': ['prettier'],
      \ 'typescriptreact': ['prettier'],
      \ }
let g:ale_rust_cargo_use_clippy = 1

let g:markdown_fold_style = 'nested'
let g:is_bash = 1

set rtp+=~/.vim/plugged/powerline/powerline/bindings/vim

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

set regexpengine=1   " Use old regexp engine because ruby syntax is slooooow
                     " with the new one

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
  set colorcolumn=-0
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
  map <buffer> j gj
  map <buffer> k gk
  map <buffer> $ g$
  map <buffer> ^ g^
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
set tags^=./.git/tags;

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
cabbrev <expr> %% expand('%:p:h')
map <leader>e :edit %%
map <leader>v :view %%

" Run a shell command and put its output in a quickfix buffer
let g:command_output=".quickfix.tmp"
function! s:RunShellCommandToQuickfix(cmdline)
  execute '!'.a:cmdline.' | tee '.g:command_output
endfunction
command! -nargs=+ -complete=command ToQF call s:RunShellCommandToQuickfix(<q-args>)

" Testing!

" This allows you to override the built-in dispatch compiler detection. As a
" bonus it effectively lets you ignore command prefixes if you want, like
" `bundle exec` and friends. I use binstubs for `bundle exec` anyway, but
" would like to set an environment variable sometimes.
let g:dispatch_compilers = {
      \ 'DISPATCH=true': '',
      \ 'spring': '',
      \ }
nnoremap <F6> :execute "Dispatch ".b:dispatch.":'".line(".")."'"<CR>
nnoremap <F7> :execute "Focus ".b:dispatch<CR>
nnoremap <F8> :Focus!<CR>
nnoremap <F9> :Dispatch<CR>

let g:rspec_command = "Dispatch DISPATCH=true rspec {spec}"
nnoremap <leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
nnoremap <Leader>f :call RunLastFailures()<CR>

function! RunLastFailures()
  execute "Dispatch DISPATCH=true rspec --only-failures"
endfunction

augroup dispatchsetup
  autocmd!
  autocmd BufNewFile,BufRead *_spec.rb let b:dispatch = 'DISPATCH=true rspec %'
  autocmd BufNewFile,BufRead *_test.rb let b:dispatch = 'testrb %'
  autocmd FileType cucumber let b:dispatch = 'cucumber %'
  autocmd FileType plantuml let b:dispatch = 'plantuml -tsvg %'
  autocmd BufNewFile,BufRead *_spec.js let b:dispatch = 'jasmine-node %'
augroup END

" Yoinked from rails.vim to support rspec keyword highlighting outside Rails
" project folders
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it its specify shared_context shared_examples shared_examples_for shared_context include_examples include_context it_should_behave_like it_behaves_like before after around subject scenario feature background given described_class violated pending expect expect_any_instance_of allow allow_any_instance_of double instance_double mock xit fit
highlight def link rubyRspec Function

" Fugitive stuff
" Clean up fugitive buffers after they're closed
augroup fugitivebufferhandling
  autocmd!
  autocmd BufReadPost fugitive://*
    \ set bufhidden=delete
  " Use '..' to navigate up git trees
  autocmd User fugitive
    \ if get(b:, 'fugitive_type', '') =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif
augroup END

augroup tsvfiles
  autocmd!
  autocmd BufRead,BufNewFile *.tsv set filetype=tsv noexpandtab tabstop=8 softtabstop=0 tw=0
  autocmd BufRead,BufNewFile *.tsv iunmap <tab>
augroup END

" git grep for the current selection
nnoremap <leader>gg :Ggrep <cword><CR><CR>:copen<CR><CR>
vnoremap <leader>gg y:Ggrep <c-r>"<CR><CR>:copen<CR><CR>
