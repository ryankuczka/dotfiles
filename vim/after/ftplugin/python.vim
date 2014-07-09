" Jedi.vim
setlocal omnifunc=jedi#completions
setlocal completeopt=menuone,longest
call jedi#configure_call_signatures()

" Folding
setlocal foldmethod=expr
setlocal foldexpr=PythonFoldExpr(v:lnum)
setlocal foldtext=PythonFoldText()

function! IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction

function! PythonFoldExpr(lnum)
  if getline(a:lnum) =~ '^\s*\%(@\|class\>\|def\>\)'
    return IndentLevel(a:lnum) + 1
  elseif getline(a:lnum) =~ '^\s*$'
    if getline(a:lnum + 1) =~ '^\s*\%(@\|class\>\|def\>\)'
      return '<' . (IndentLevel(a:lnum + 1) + 1)
    else
      return '='
    endif
  " elseif getline(a:lnum) =~ '\[[^\]]*$\|{[^}]*$'
  "   return IndentLevel(a:lnum) + 1
  " elseif getline(a:lnum) =~ '^[^\[]*\]\|^[^{]*}'
  "   return '<' . (IndentLevel(nextnonblank(a:lnum)) + 1)
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
  let curline = v:foldstart
  while getline(curline) =~ '^\s*@'
    let text = text.': '.substitute(substitute(getline(curline + 1), '^\s*\(.\{-}\)\s*$', '\1', ''), '\%(def\|class\) ', '', 'g')
    let curline = curline + 1
  endwhile

  let text = substitute(text, '^\s*\(.\{-}\)\s*$', '\1', '')
  return '+'.repeat('-', v:foldlevel).size.'lines: '.text
endfunction
