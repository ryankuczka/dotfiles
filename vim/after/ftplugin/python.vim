" Folding: {{{
" ========
" expr folding doesn't play nice with neocomplete
setlocal foldmethod=expr
setlocal foldexpr=PythonFoldExpr(v:lnum)
setlocal foldtext=PythonFoldText()

function! IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction

function! PythonFoldExpr(lnum)
  let text = getline(a:lnum)
  let chars = split(text, '\zs')

  if text =~ '^\s*\%(@\|class\>\|def\>\)'
    return IndentLevel(a:lnum) + 1
  elseif count(chars, '{') > count(chars, '}') || count(chars, '[') > count(chars, ']')
    return 'a1'
  elseif count(chars, '}') > count(chars, '{') || count(chars, ']') > count(chars, '[')
    return 's1'
  elseif text =~ '^\s*$'
    if IndentLevel(a:lnum + 1) == 0 && getline(a:lnum + 1) !~ '^\s*$'
      return '<1'
    elseif IndentLevel(a:lnum + 1) == 1
      return '<2'
    else
      return '='
    endif
  elseif indent(a:lnum) == 0
    return 0
  endif
  return '='
endfunction

function! PythonFoldText()
  let size = 1 + v:foldend - v:foldstart
  if size < 10
    let size = '  '.size.' '
  elseif size < 100
    let size = ' '.size.' '
  elseif size < 1000
    let size = size.' '
  endif

  let text = getline(v:foldstart)
  if text =~ '^.\{-}{[^}]*$'
    let text = text.'}'
  elseif text =~ '^.\{-}\[[^\]]*$'
    let text = text.']'
  elseif text =~ '^\s*@'
    let curline = v:foldstart
    while getline(curline) =~ '^\s*@'
      let text = text.': '.substitute(substitute(getline(curline + 1), '^\s*\(.\{-}\)\s*$', '\1', ''), '\%(def\|class\) ', '', 'g')
      let curline = curline + 1
    endwhile
  endif

  let text = substitute(text, '^\s*\(.\{-}\)\s*$', '\1', '')
  return '+'.repeat('-', v:foldlevel).size.'lines: '.text
endfunction
