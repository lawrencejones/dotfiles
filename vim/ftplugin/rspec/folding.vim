setlocal foldmethod=expr
setlocal foldexpr=GetRspecFold(v:lnum)

function! GetRspecFold(lnum)

  let crrt_line = a:lnum

  " For the first line, set fold to 0
  if a:lnum == 1
    return 0

  " Else waterfall for whitespace
  elseif getline(crrt_line) =~? '\v^\s*$'
    if IsBlockEnd(crrt_line-1)
      return GetRspecFold(crrt_line-1)-1
    else
      return '-1'
    endif
  endif

  let prev_line  = PrevNonBlankLine(crrt_line)
  let prev_level = GetRspecFold(prev_line)

  if IsBlockEnd(prev_line)
    let prev_level -= 1
  endif

  if IsBlockBegin(crrt_line)
    return prev_level + 1
  endif

  return prev_level

endfunction

" Finds the previous non-blank line number from the given lnum.
function! PrevNonBlankLine(lnum)

  let current = a:lnum - 1

  while current > 1
    if getline(current) =~? '\v\S'
      return current
    endif
    let current -= 1
  endwhile

  return current

endfunction

function! IsBlockBegin(lnum)
  return getline(a:lnum) =~? '\v^\s*(context|before|after|it|specify|describe).*do\s*$'
endfunction

function! IsBlockEnd(lnum)
  return getline(a:lnum) =~? '\v^\s*end\s*$'
endfunction

function! IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction

