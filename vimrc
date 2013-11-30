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
