set textwidth=90

" Converts any "key" => "value" hashes in selection to key: "value"
vnoremap <leader>h :s/\v"([^"]+)"\s*\=\>\s*/\1: /g<CR>

" vim-rails, open or create related spec in split
noremap <leader>r :exec 'Espec '. substitute(@%, 'app/\\|.rb$', '', 'gi') . '!' <CR>
