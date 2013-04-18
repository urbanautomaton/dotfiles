" Vim compiler file
" Language: jasmine-node
" Maintainer: Simon Coffey <simon@NOSPAMurbanautomaton.com>

if exists("current_compiler")
  finish
endif
let current_compiler = "jasmine-node"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=jasmine-node

CompilerSet errorformat=
      \%-Z,
      \%E\ \ %\\d%\\+)\ %m,
      \%-G%.%#/jasmine%.%#.js%.%#,
      \%Z\ \ \ \ at\ %.%#\ (%f:%l:%c),
      \%C\ \ \ Message:,
      \%C\ \ \ \ \ %m,
      \%C%>\ \ \ Stacktrace:,
      \%C\ \ \ \ \ %.%#,
      \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:
