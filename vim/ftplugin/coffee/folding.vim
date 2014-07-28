setlocal foldmethod=expr
setlocal foldexpr=GetCoffeeFold(v:lnum)

function! IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction

function! NextNonBlankLine(lnum)
  let numlines = line('$')
  let current = a:lnum + 1

  while current <= numlines

    if getline(current) =~? '\v\S'
      return current
    endif

    let current += 1

  endwhile

  return -2
endfunction


function! GetCoffeeFold(lnum)

  " if getline(a:lnum) =~? '\v^\s*$'
  "   return '-1'
  " endif

  let this_indent = IndentLevel(a:lnum)
  let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

  if next_indent <= this_indent
    return this_indent
  elseif next_indent > this_indent
    return next_indent
  else
    return '-1'
  endif

endfunction

