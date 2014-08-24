setlocal foldmethod=expr
setlocal foldexpr=GetJakeFold(v:lnum)

function! GetJakeFold(lnum)

  let crrt_line = a:lnum

  " For the first line, set fold to 0
  if crrt_line <= 1
    return 0
  endif

  let prev_begin = PrevBeginLine(crrt_line)
  let prev_level = GetJakeFold(prev_begin)

  " For blanks, take previous begin level
  if IsBlankLine(crrt_line)
    return GetJakeFold(PrevBeginLine(NextNonBlank(crrt_line)))

  " If a begin line, then increment previous begin level
  elseif IsBeginLine(crrt_line)
    return prev_level + 1

  " Otherwise waterfall previous level
  else
    return prev_level
  endif

endfunction

function! NextNonBlank(lnum)

  let line = a:lnum + 1
  let maxline = line('$')

  while line < maxline
    if NonBlankLine(line)
      return line
    endif
    let line += 1
  endwhile

  return a:lnum

endfunction

" Finds the previous non-blank begin line
function! PrevBeginLine(lnum)

  let max_indent = IndentLevel(a:lnum)
  let line = a:lnum - 1

  while line > 1

    let line_indent = IndentLevel(line)

    if IsBeginLine(line) && (line_indent < max_indent)
      return line
    endif

    if NonBlankLine(line) && (line_indent < max_indent)
      let max_indent = line_indent
    endif

    let line -= 1

  endwhile

  return line

endfunction

function! NonBlankLine(lnum)
  return !IsBlankLine(a:lnum)
endfunction

function! IsBlankLine(lnum)
  return getline(a:lnum) !~? '\v\S'
endfunction

function! IsBeginLine(lnum)
  return getline(a:lnum) =~? '\v^\s*(namespace|task|file).*-\>\s*$'
endfunction

function! IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction

