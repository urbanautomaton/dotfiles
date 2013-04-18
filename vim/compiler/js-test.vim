" Vim compiler file
" Language: JS.Test
" Maintainer: Simon Coffey <simon@NOSPAMurbanautomaton.com>

if exists("current_compiler")
  finish
endif
let current_compiler = "js-test"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=node

CompilerSet errorformat=
      \%-Z,
      \%Z\ \ \ \ at\ %.%#\ (%f:%l:%c),
      \%E%\\d%\\+)\ %trror:\ %m,
      \%E%\\d%\\+)\ %tailure:\ %m,
      \%C%m,
      \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:
