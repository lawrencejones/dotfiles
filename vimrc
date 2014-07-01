set nocompatible              " be iMproved, required
filetype off                  " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" --------------- Plugins installed -------------------------------------------

Plugin 'gmarik/Vundle.vim' 
Plugin 'scrooloose/syntastic'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'
Plugin 'airblade/vim-gitgutter'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-surround'
Plugin 'wincent/Command-T'
Plugin 'ap/vim-css-color'
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/taglist.vim'
Plugin 'bronson/vim-trailing-whitespace'

call vundle#end()

syntax on                     " Turn syntax on
filetype plugin indent on     " Set to detect filetype

let g:tagbar_left=1           " Vim tagbar shortcut

" --------------- Color and Scheme Preferences --------------------------------

colorscheme molokai
let g:molokai_original = 1

set t_ut=    " Disable deleted coloring
set t_Co=256 " Force 256 colors

" --------------- Indentation and Formatting ----------------------------------

set autoindent      " Copy indent from current line when starting a new one
set smartindent     " Smart autoindenting when starting a new line 
set smarttab        " <Tab> depends on the value of 'shiftwidth'
set expandtab       " Use appropriate numebr of spaces rather than tab
set shiftround      " Round indent to multiple of shiftwidth
set nowrap          " Don't wrap lines longer than width of the window
set scrolloff=5     " minimal number of lines above/below cursor on scrolling
set tabstop=2       " number of spaces that a <Tab> counts for normally
set softtabstop=2   " number of spaces that a <Tab> counts for while editing
set shiftwidth=2    " Values used by smarttab setting

" --------------- General Settings --------------------------------------------

set nu                            " Turn on numbers
set ruler                         " Show line and col
set mouse=a                       " Enable mouse scrolling, pane selection
set statusline+=%F                " Put filepath in status
set laststatus=2                  " Set status to visible
set directory=~/.vim/swapfiles//  " Change swapfile location for out of wd
set fdm=marker                    " Set default fold method to marker
set backspace=indent,eol,start    " Allow backspace over everything in insert mode

autocmd BufRead * set tags=./tags,tags;$HOME  " Look for tags

" --------------- Searching Settings ------------------------------------------

set hlsearch        " highlight all matches of a search pattern
set incsearch       " Show where the pattern, while typying a search command
set smartcase       " Override 'ignorecase' for upper case search patterns
set ignorecase      " Ignore case of normal letters


" --------------- Filetype Preferences ----------------------------------------

au FileType make set noexpandtab  " Prevent expandtab in makefiles
au BufRead,BufNewFile Make.*,Makefile,makefile set ft=make " Set filetype
au BufRead,BufNewFile Jakefile.* set fdm=marker " Set marker foldmethod jake
au BufRead,BufNewFile package.json set ft=javascript  " Force JSON hl
au BufReadPost *.pegjs set syntax=javascript  " Force JS hl
au BufRead,BufNewFile *.pro set syntax=prolog " Detect prolog

" --------------- GitGutter Plugin Settings -----------------------------------

let g:gitgutter_enabled = 0             " Start by default
autocmd BufRead * GitGutterSignsEnable  " Turn gitgutter on

" Enabled/Disabled GitGutter with '\g'
map <Leader>g :GitGutterToggle<CR>

" Go to next hunk with '\\g'
map <Leader>ng :GitGutterNextHunk<CR>

" Go to previous hunk with '\pg'
map <Leader>pg :GitGutterPrevHunk<CR>

" --------------- General Shortcuts -------------------------------------------

" Enable yanking to system clipboard
map <leader> y('<,'>! pbcopy; pbpaste) 
" Map tagbar toggle
nmap <F8> :TagbarToggle<CR>
" Map space to toggle current fold
noremap <Space> za  

" --------------- Coffee-Script Preferences -----------------------------------

" Configure coffeescript errors
let g:syntastic_coffee_checkers = ['coffeelint', 'coffee']

" Configure coffeetags
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif


" --------------- Apiary Preferences ------------------------------------------

" Configures extra highlighting for my apib extensions of MODEL and INCLUDE
function! HighlightApibExt()

  syn clear " Initially clear syntax

  " Keywords (MODEL | INCLUDE)
  syn keyword apibKeywords MODEL INCLUDE
  hi def link apibKeywords Type

  " Path following keywords
  syn match modelName /\(MODEL\|INCLUDE\|FORMAT\|HOST\)\@<= [^\]]\+/ display
  hi def link modelName Exception

  " Set preprocessor directives to white
  syn match preprocessorDirectives /\[[^\]]\+\]([^)]\+)/ contains=apibKeywords,modelName display
  hi def link preprocessorDirectives Normal

  " Change standard text to comment level
  syn match bodyText /^[^#].\+/ contains=apibKeywords,modelName,preprocessorDirectives display
  hi def link bodyText Comment

  " Top level keys
  syn keyword topLevel FORMAT HOST
  hi def link topLevel Constant


endfunction

autocmd BufNewFile,BufRead *.apib call HighlightApibExt()
autocmd BufNewFile,BufRead *.apib set shiftwidth=4

" --------------- Java Proferences --------------------------------------------

function! SetupJava()

  " Set folding to indent, and hopefully display only
  " top level class names and method sigs.
  set foldlevel=1
  set foldmethod=indent

  " Enable autocompletion with C-n
  set complete=.,w,b,u,t,i

endfunction

autocmd BufNewFile,BufRead *.java call SetupJava()
