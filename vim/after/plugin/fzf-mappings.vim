" FZF
nnoremap <C-p> :call fzf#run(fzf#wrap({ 'source': 'git ls-files', 'down': '40%' }))<CR>
