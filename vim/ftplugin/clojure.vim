augroup clojuresettings
  autocmd!
  autocmd BufNewFile,BufRead *.clj RainbowParenthesesToggle
  autocmd BufNewFile,BufRead *.cljs RainbowParenthesesToggle
augroup END
" Connect to a phantomjs-backed clojurescript repl
command! Piggie :Piggieback (cemerick.austin/exec-env)
" Connect to a chrome-backed clojurescript browser repl
command! Biggie :Piggieback (cemerick.austin/exec-env :exec-cmds ["open" "-ga" "/Applications/Google Chrome.app"])
