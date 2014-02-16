execute pathogen#infect()
syntax on
") Add for silent coffee compilation ---------------------------
") au BufWritePost *.coffee silent CoffeeMake!
") Sets default 2 space for everything!
au BufNewFile,BufReadPost * setl shiftwidth=2 expandtab
colorscheme molokai
let g:molokai_original = 1
") Indentation behaviour ---------------------------------------
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set ruler
filetype indent on
filetype on
au FileType make set noexpandtab
") Force syntax highlighting of javascript for pegjs files
au BufReadPost *.pegjs set syntax=javascript
") Force 256 colours
set t_Co=256
") Turn off vi compatibility
set nocompatible
") Add recently accessed projects menu (project plugin)
set viminfo^=!
") Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
") Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'
") Allow syntax completion
filetype plugin on
set omnifunc=syntaxcomplete
") Set foldmethod
au BufRead,BufNewFile *.pro set syntax=prolog
") Vim tagbar shortcut
let g:tagbar_left=1
autocmd VimEnter set tags?
")autocmd VimEnter *.c TagbarOpen
nmap <F8> :TagbarToggle<CR>
") Configure coffeescript errors
let g:syntastic_coffee_checkers = ['coffeelint', 'coffee']
") Change swapfile location for out of source
set directory=~/.vim/swapfiles//
") Disable deleted coloring
set t_ut=
") Load in scripts
so $HOME/.vim/functions/c_prototype
") Turn on numbers
set nu
