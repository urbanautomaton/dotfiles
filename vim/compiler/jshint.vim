" Vim compiler file
" Language: jasmine-node
" Maintainer: Simon Coffey <simon@NOSPAMurbanautomaton.com>

if exists("current_compiler")
  finish
endif
let current_compiler = "jshint"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=jshint

CompilerSet errorformat=
      \%f:\ line\ %l\\,\ col\ %c\\,\ %m,
      \%-G


let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:
