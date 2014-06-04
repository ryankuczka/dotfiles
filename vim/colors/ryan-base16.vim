"
" Name: Ryan Base 16 Theme
" Author: Ryan Kuczka
"

unlet! g:colors_name
hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'ryan-base16'

" Color Definitions: "{{{1
" ==================
if &background == 'dark'
    let s:gui_colors = ['#151515', '#202020', '#303030', '#505050',
                       \'#b0b0b0', '#d0d0d0', '#e0e0e0', '#f5f5f5',
                       \'#ac4142', '#d28445', '#f4bf75', '#90a959',
                       \'#75b5aa', '#6a9fb5', '#aa759f', '#8f5536']

    if exists('g:base16colorspace') && g:base16colorspace == "256"
        let s:cterm_colors = ['00', '18', '19', '08', '20', '07', '21', '15',
                             \'01', '16', '03', '02', '06', '04', '05', '17']
    else
        let s:cterm_colors = ['00', '10', '11', '08', '12', '07', '13', '15',
                             \'01', '09', '03', '02', '06', '04', '05', '14']
    endif
else
    let s:gui_colors = ['#f5f5f5', '#e0e0e0', '#d0d0d0', '#b0b0b0',
                       \'#505050', '#303030', '#202020', '#151515',
                       \'#ac4142', '#d28445', '#f4bf75', '#90a959',
                       \'#75b5aa', '#6a9fb5', '#aa759f', '#8f5536']

    if exists('g:base16colorspace') && g:base16colorspace == "256"
        let s:cterm_colors = ['15', '21', '07', '20', '08', '19', '18', '00',
                             \'01', '16', '03', '02', '06', '04', '05', '17']
    else
        let s:cterm_colors = ['15', '13', '07', '12', '08', '11', '10', '00',
                             \'01', '09', '03', '02', '06', '04', '05', '14']
    endif
endif

" Highlighting Function: {{{1
" ======================
function! <sid>hi(group, fg, bg, attr)
    if a:fg != ''
        exec 'hi '.a:group.' guifg='.s:gui_colors[a:fg].' ctermfg='.s:cterm_colors[a:fg]
    endif
    if a:bg != ''
        exec 'hi '.a:group.' guibg='.s:gui_colors[a:bg].' ctermbg='.s:cterm_colors[a:bg]
    endif
    if a:attr != ''
        exec 'hi '.a:group.' gui='.a:attr.' cterm='.a:attr.' term='.a:attr
    endif
endfunction

" Vim UI Colors: {{{1
" ==============
call <sid>hi('Bold'        ,   '',   '', 'bold')
call <sid>hi('Debug'       ,  '8',   '', '')
call <sid>hi('Directory'   , '12',   '', '')
call <sid>hi('ErrorMsg'    ,  '8',  '0', '')
call <sid>hi('Exception'   ,  '8',   '', '')
call <sid>hi('FoldColumn'  ,   '',  '1', '')
call <sid>hi('Folded'      ,  '3',  '1', '')
call <sid>hi('IncSearch'   ,  '1',  '9', 'none')
call <sid>hi('Italic'      ,   '',   '', 'none')
call <sid>hi('Macro'       ,  '8',   '', '')
call <sid>hi('MatchParen'  ,  '0', '10', '')
call <sid>hi('ModeMsg'     , '11',   '', '')
call <sid>hi('MoreMsg'     , '11',   '', '')
call <sid>hi('Question'    , '10',   '', '')
call <sid>hi('Search'      ,  '3', '10', '')
call <sid>hi('SpecialKey'  , '14',   '', '')
call <sid>hi('TooLong'     ,  '8',   '', '')
call <sid>hi('Underlined'  ,  '8',   '', '')
call <sid>hi('Visual'      ,   '',  '2', '')
call <sid>hi('VisualNOS'   ,  '8',   '', '')
call <sid>hi('WarningMsg'  ,  '8',   '', '')
call <sid>hi('WildMenu'    ,  '2',  '4', '')
call <sid>hi('Title'       , '13',   '', '')
call <sid>hi('Conceal'     , '13',  '0', '')
call <sid>hi('Cursor'      ,  '0',  '5', '')
call <sid>hi('NonText'     ,  '3',   '', '')
call <sid>hi('Normal'      ,  '4',  '0', '')
call <sid>hi('LineNr'      ,  '3',  '1', '')
call <sid>hi('SignColumn'  ,  '3',  '1', '')
call <sid>hi('StatusLine'  ,  '4',  '2', 'bold')
call <sid>hi('StatusLineNC',  '4',  '2', 'none')
call <sid>hi('VertSplit'   ,  '2',  '0', 'none')
call <sid>hi('ColorColumn' ,   '',  '1', 'none')
call <sid>hi('CursorColumn',   '',  '1', 'none')
call <sid>hi('CursorLine'  ,   '',  '1', 'none')
call <sid>hi('CursorLineNr', '10',  '1', '')
call <sid>hi('PMenu'       ,  '4',  '1', 'none')
call <sid>hi('PMenuSel'    ,  '1',  '4', '')
call <sid>hi('TabLine'     ,  '3',  '1', 'none')
call <sid>hi('TabLineFill' ,  '3',  '1', 'none')
call <sid>hi('TabLineSel'  , '11',  '1', 'none')

" Standard Syntax Highlighting: {{{1
" =============================
call <sid>hi('Boolean'     ,  '9',   '', '')
call <sid>hi('Character'   ,  '8',   '', '')
call <sid>hi('Comment'     ,  '3',   '', '')
call <sid>hi('Conditional' ,  '8',   '', 'none')
call <sid>hi('Constant'    ,  '4',   '', '')
call <sid>hi('Define'      , '14',   '', 'none')
call <sid>hi('Delimiter'   , '13',   '', '')
call <sid>hi('Float'       ,  '9',   '', '')
call <sid>hi('Function'    , '13',   '', '')
call <sid>hi('Identifier'  , '13',   '', 'none')
call <sid>hi('Include'     , '13',   '', '')
call <sid>hi('Keyword'     , '14',   '', '')
call <sid>hi('Label'       , '10',   '', '')
call <sid>hi('Number'      ,  '9',   '', '')
call <sid>hi('Operator'    ,  '8',   '', 'none')
call <sid>hi('PreProc'     , '10',   '', '')
call <sid>hi('Repeat'      ,  '8',   '', '')
call <sid>hi('Special'     ,  '8',   '', 'bold')
call <sid>hi('SpecialChar' , '15',   '', '')
call <sid>hi('Statement'   ,  '8',   '', 'none')
call <sid>hi('StorageClass', '9',   '', '')
call <sid>hi('String'      , '11',   '', '')
call <sid>hi('Structure'   , '14',   '', '')
call <sid>hi('Tag'         , '10',   '', '')
call <sid>hi('Todo'        , '10',  '1', '')
call <sid>hi('Type'        ,  '9',   '', 'none')
call <sid>hi('Typedef'     , '10',   '', '')

" Spelling Highlighting: {{{1
" ======================
call <sid>hi('SpellBad'    ,   '',  '0', 'undercurl')
call <sid>hi('SpellLocal'  ,   '',  '0', 'undercurl')
call <sid>hi('SpellCap'    ,   '',  '0', 'undercurl')
call <sid>hi('SpellRare'   ,   '',  '0', 'undercurl')

" Diff Highlighting: {{{1
" ==================
call <sid>hi('DiffAdd'     ,  '0', '11', '')
call <sid>hi('DiffChange'  ,  '0', '10', '')
call <sid>hi('DiffDelete'  ,  '0',  '8', '')
call <sid>hi('DiffText'    ,  '0',  '9', 'underline')
call <sid>hi('DiffAdded'   , '11',  '0', '')
call <sid>hi('DiffFile'    ,  '8',  '0', '')
call <sid>hi('DiffNewFile' , '11',  '0', '')
call <sid>hi('DiffLine'    , '13',  '0', '')
call <sid>hi('DiffRemoved' ,  '8',  '0', '')

" Python Highlighting: {{{1
" ====================
call <sid>hi('PythonDot'        , '8', '', '')
call <sid>hi('pythonBytesEscape', '8', '', 'bold')

" Javascript Highlighting: {{{1
" ========================
call <sid>hi('javaScript'      ,  '5', '', '')
call <sid>hi('javaScriptBraces', '13', '', 'bold')
call <sid>hi('javaScriptNumber',  '9', '', '')

" Git Highlighting: {{{1
" =================
call <sid>hi('gitCommitOverflow'     ,  '8', '', '')
call <sid>hi('gitCommitSummary'      , '11', '', '')
call <sid>hi('gitCommitSelectedType' , '11', '', '')
call <sid>hi('gitCommitDiscardedType',  '8', '', '')

" Django Highlighting: {{{1
" ====================
call <sid>hi('djangoTagBlock', '14', '', '')

" CSS Highlighting: {{{1
" =================
call <sid>hi('cssBraces'        , '13', '', 'bold')

" Remove Functions and Variables " {{{1
delf <sid>hi
unlet s:gui_colors s:cterm_colors

" vim:foldlevel=0
