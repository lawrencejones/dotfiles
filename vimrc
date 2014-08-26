set nocompatible              " be iMproved, required
filetype off                  " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Source ninja
let ninja_file=expand('/apollo/env/envImprovement/var/vimruntimehook')
if filereadable(ninja_file) | exec "source " . ninja_file | endif

" --------------- Plugins installed -------------------------------------------

" Allow vundle to manage itself
Plugin 'gmarik/Vundle.vim'

" Bundle manifest
Plugin 'scrooloose/syntastic'
Plugin 'slim-template/vim-slim'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'
Plugin 'airblade/vim-gitgutter'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-surround'
Plugin 'garybernhardt/selecta' " Ruby script
Plugin 'ap/vim-css-color'
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/taglist.vim'
Plugin 'mintplant/vim-literate-coffeescript'
Plugin 'scrooloose/nerdtree'
Plugin 'epeli/slimux'

call vundle#end()

syntax on                     " Turn syntax on
filetype plugin indent on     " Set to detect filetype

let g:tagbar_left=1           " Vim tagbar shortcut

" --------------- Color and Scheme Preferences --------------------------------

colorscheme molokai
let g:molokai_original = 1

set t_ut=             " Disable deleted coloring
set t_Co=256          " Force 256 colors
syn sync fromstart    " Calculate syntax colors from start of file

" Turn off visual/audible bell
set visualbell
set t_vb=

" Forces a syntax hl refresh
nnoremap <leader>S :syn sync fromstart<CR>

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
set nobackup                      " Prevents potential slow write
set statusline+=%F                " Put filepath in status
set laststatus=2                  " Set status to visible
set directory=~/.vim/swapfiles//  " Change swapfile location for out of wd
set fdm=marker                    " Set default fold method to marker
set backspace=indent,eol,start    " Allow backspace over everything in insert mode

autocmd BufRead * set tags=./tags,tags;$HOME        " Look for tags
let g:syntastic_mode_map = {
  \ "mode": "active",
  \ "passive_filetypes": ["haml", "scss", "sass"] }

" --------------- ColorColumn Toggling ----------------------------------------

" Alternately toggles a color column on or off. Mapped to leader
" key c.
function! g:ToggleColorColumn()
  if &colorcolumn != ''
    setlocal colorcolumn&
  else
    setlocal colorcolumn=80
  endif
endfunction

nnoremap <leader>C :call g:ToggleColorColumn()<CR>

" --------------- Searching Settings ------------------------------------------

set hlsearch        " highlight all matches of a search pattern
set incsearch       " Show where the pattern, while typying a search command
set smartcase       " Override 'ignorecase' for upper case search patterns
set ignorecase      " Ignore case of normal letters

" --------------- Filetype Preferences ----------------------------------------

au FileType make set noexpandtab                " Force tabs in makefiles
au BufRead,BufNewFile Make.*,Makefile,makefile set ft=make    " Set filetype
au BufRead,BufNewFile package.json set ft=javascript          " Force JSON hl
au BufReadPost *.pegjs set syntax=javascript    " Force JS hl
au BufRead,BufNewFile *.pro set syntax=prolog   " Detect prolog
au BufRead,BufNewFile Gemfile set ft=ruby       " Set ruby syntax for Gemfiles

" --------------- GitGutter Plugin Settings -----------------------------------

let g:gitgutter_enabled = 0             " Start by default
autocmd BufRead * GitGutterEnable       " Turn gitgutter on

" Enabled/Disabled GitGutter with '\g'
map <Leader>g :GitGutterToggle<CR>

" Go to next hunk with '\\g'
map <Leader>ng :GitGutterNextHunk<CR>

" Go to previous hunk with '\pg'
map <Leader>pg :GitGutterPrevHunk<CR>

" --------------- General Shortcuts -------------------------------------------

" Enable yanking to system clipboard
map <leader>y('<,'>! pbcopy; pbpaste)
" Map tagbar toggle
nmap <F8> :TagbarToggle<CR>

" --------------- Tmux Integration --------------------------------------------

if $TMUX != '' 

  " Integrate movement between tmux/vim panes/windows
 
  function! TmuxMove(direction)

    " Check if we are currently focusing on a edge window.
    " To achieve that,  move to/from the requested window and
    " see if the window number changed

    let oldw = winnr()
    silent! exe 'wincmd ' . a:direction
    let neww = winnr()
    silent! exe oldw . 'wincmd'

    if oldw == neww
      " The focused window is at an edge, so ask tmux to switch panes
      if a:direction == 'j'
        call system("tmux select-pane -D")
      elseif a:direction == 'k'
        call system("tmux select-pane -U")
      elseif a:direction == 'h'
        call system("tmux select-pane -L")
      elseif a:direction == 'l'
        call system("tmux select-pane -R")
      endif
    else
      exe 'wincmd ' . a:direction
    end
  endfun
 
  function! TmuxSharedYank()
    " Send the contents of the 't' register to a temporary file, invoke
    " copy to tmux using load-buffer, and then to xclip
    " FIXME for some reason, the 'tmux load-buffer -' form will hang
    " when used with 'system()' which takes a second argument as stdin.
    let tmpfile = tempname()
    call writefile(split(@t, '\n'), tmpfile, 'b')
    call system('tmux load-buffer '.shellescape(tmpfile).';tmux show-buffer | xclip -i -selection clipboard')
    call delete(tmpfile)
  endfunction
 
  function! TmuxSharedPaste()
    " Put tmux copy buffer into the t register, the mapping will handle
    " pasting into the buffer
    let @t = system('xclip -o -selection clipboard | tmux load-buffer -;tmux show-buffer')
  endfunction
 
 
  nnoremap <silent> <c-w>j :silent call TmuxMove('j')<cr>
  nnoremap <silent> <c-w>k :silent call TmuxMove('k')<cr>
  nnoremap <silent> <c-w>h :silent call TmuxMove('h')<cr>
  nnoremap <silent> <c-w>l :silent call TmuxMove('l')<cr>
  nnoremap <silent> <c-w><down> :silent call TmuxMove('j')<cr>
  nnoremap <silent> <c-w><up> :silent call TmuxMove('k')<cr>
  nnoremap <silent> <c-w><left> :silent call TmuxMove('h')<cr>
  nnoremap <silent> <c-w><right> :silent call TmuxMove('l')<cr>
 
  vnoremap <silent> <esc>y "ty:call TmuxSharedYank()<cr>
  vnoremap <silent> <esc>d "td:call TmuxSharedYank()<cr>
  nnoremap <silent> <esc>p :call TmuxSharedPaste()<cr>"tp
  vnoremap <silent> <esc>p d:call TmuxSharedPaste()<cr>h"tp  

  set clipboard= " Use this or vim will automatically put deleted text into x11 selection('*' register) which breaks the above map
 
  " Quickly send text to a pane using f6
  nnoremap <silent> <f6> :SlimuxREPLSendLine<cr>  
  inoremap <silent> <f6> <esc>:SlimuxREPLSendLine<cr>i " Doesn't break out of insert
  vnoremap <silent> <f6> :SlimuxREPLSendSelection<cr>
 
  " Quickly restart your debugger/console/webserver. Eg: if you are developing a node.js web app
  " in the 'serve.js' file you can quickly restart the server with this mapping:
  nnoremap <silent> <f5> :call SlimuxSendKeys('C-C " node serve.js" Enter')<cr>
  " Pay attention to the space before 'node', this is actually required as send-keys will eat the first key
 
endif

" --------------- Folding! ----------------------------------------------------

" Map space to toggle current fold
noremap <Space> za

" Turn foldcolumn viewing on for a fold visualization
nnoremap <leader>f :call FoldColumnToggle()<cr>
function! FoldColumnToggle()
  if &foldcolumn
    setlocal foldcolumn=0
  else
    setlocal foldcolumn=4
  endif
endfunction

" Configure fold status text
if has("folding")

  set foldtext=MyFoldText()

  function! MyFoldText()

    " for now, just don't try if version isn't 7 or higher
    if v:version < 701
      return foldtext()
    endif

    " clear fold from fillchars to set it up the way we want later
    let &l:fillchars = substitute(&l:fillchars,',\?fold:.','','gi')
    let l:numwidth = (v:version < 701 ? 8 : &numberwidth)

    if &fdm=='diff'
      let l:linetext=''
      let l:foldtext='---------- '.(v:foldend-v:foldstart+1).' lines the same ----------'
      let l:align = winwidth(0)-&foldcolumn-(&nu ? Max(strlen(line('$'))+1, l:numwidth) : 0)
      let l:align = (l:align / 2) + (strlen(l:foldtext)/2)

      " note trailing space on next line
      setlocal fillchars+=fold:\ 

    elseif !exists('b:foldpat') || b:foldpat==0
      let l:foldtext = ' '.(v:foldend-v:foldstart).' lines folded'.v:folddashes.'|'
      let l:endofline = (&textwidth>0 ? &textwidth : 80)
      let l:linetext = strpart(getline(v:foldstart),0,l:endofline-strlen(l:foldtext))
      let l:align = l:endofline-strlen(l:linetext)
      setlocal fillchars+=fold:-

    elseif b:foldpat==1
      let l:align = winwidth(0)-&foldcolumn-(&nu ? Max(strlen(line('$'))+1, l:numwidth) : 0)
      let l:foldtext = ' '.v:folddashes
      let l:linetext = substitute(getline(v:foldstart),'\s\+$','','')
      let l:linetext .= ' ---'.(v:foldend-v:foldstart-1).' lines--- '
      let l:linetext .= substitute(getline(v:foldend),'^\s\+','','')
      let l:linetext = strpart(l:linetext,0,l:align-strlen(l:foldtext))
      let l:align -= strlen(l:linetext)
      setlocal fillchars+=fold:-
    endif

    return printf('%s%*s', l:linetext, l:align, l:foldtext)

  endfunction

endif

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

  " Adjust tab spacing to 4 spaces
  set shiftwidth=4
  set tabstop=4

  " Enable autocompletion with C-n
  set complete=.,w,b,u,t,i

endfunction

autocmd BufNewFile,BufRead *.java call SetupJava()

" --------------- Selecta Configuration ---------------------------------------

function! SetupRuby()

  " Configure syntax folding, with base foldlevel
  set foldmethod=syntax
  set foldlevel=1

endfunction

autocmd BufNewFile,BufRead *.rb call SetupRuby()
autocmd BufNewFile,BufRead *_spec.rb set ft=ruby.rspec

" --------------- Selecta Configuration ---------------------------------------

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)

  try
    silent let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection

endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>t :call SelectaCommand("find . \\(
      \ -path ./.git -o
      \ -path ./node_modules -o
      \ -path ./logs -o
      \ -path ./tmp -o
      \ -path ./public
      \ \\) -prune -o -type f", "", ":e")<cr>


