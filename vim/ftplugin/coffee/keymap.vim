" Adds .only suffix to a block in mocha specs
nnoremap <leader>o V:s/\v(describe\|it\|context)([^.])/\1.only\2/<CR>:noh<CR>

" Removes .only
nnoremap <leader>O v:s/.only//g<CR>
