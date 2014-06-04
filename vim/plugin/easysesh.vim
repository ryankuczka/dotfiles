" easysesh.vim - An easy way of maintaining sessions
" Maintainer: Ryan Kuczka <ryan.kuczka@gmail.com>
" Last Updated: 2014-06-03

if exists('g:loaded_easysesh') || v:version < 700 || &cp
    finish
endif
let g:loaded_easysesh = 1

if exists('g:easysesh_dir')
    let s:base_dir = g:easysesh_dir
else
    let s:base_dir = has('unix') ? $HOME . '/.vim/sessions' : $VIM . '/vimfiles/sessions'
endif

" Util Functions: {{{1
" ===============
" String Utils: {{{2
" =============
function! s:clean(string, replace_slash)
    let l:cleaned_string = substitute(a:string, '\n', '', 'g')
    let l:cleaned_string = substitute(l:cleaned_string, '^\s*\(.\{0}\)\s*$', '\1', '')
    if a:replace_slash
        let l:cleaned_string = substitute(l:cleaned_string, '/', '_', 'g')
    endif
    return l:cleaned_string
endfunction
" }}}2

" Path Utils: {{{2
" ===========
function! s:os_sep() " {{{3
    return has('unix') ? '/' : '\'
endfunction

function! s:is_abs_path(path) " {{{3
    return a:path[0] ==# s:os_sep()
endfunction

function! s:parent_dir(path) " {{{3
    let l:sep = s:os_sep()
    let l:front = s:is_abs_path(a:path) ? l:sep : ''
    return l:front . join(split(a:path, l:sep)[:-2], l:sep)
endfunction
" }}}2

" Git Utils: {{{2
" ==========
function! s:in_git_repo() " {{{3
    return empty(s:clean(system('\git status > /dev/null'), 0))
endfunction

function! s:find_git_dir(path) " {{{3
    if !s:in_git_repo()
        return
    elseif isdirectory(a:path . '/.git')
        return a:path . '/.git'
    elseif has('file_in_path') && has('path_extra')
        return finddir('.git', a:path . ';')
    else
        return s:recurse_find_git_dir(a:path)
    endif
endfunction

function! s:recurse_find_git_dir(path) " {{{3
    return isdirectory(a:path . '/.git') ? a:path . '/.git' : s:recurse_find_git_dir(s:parent_dir(a:path))
endfunction

function! s:get_project_dir() " {{{3
    return s:parent_dir(s:find_git_dir(getcwd()))
endfunction

function! s:get_branch_name() " {{{3
    return s:clean(system('\git rev-parse --abbrev-ref HEAD'), 1)
endfunction
" }}}2

" Session Paths: {{{2
" ==============
function! s:session_dir() " {{{3
    if exists('g:easysesh_use_cwd') && g:easysesh_use_cwd
        return getcwd() . '/Session.vim'
    elseif s:in_git_repo()
        return s:base_dir . s:get_project_dir()
    else
        return s:base_dir . getcwd()
    endif
endfunction

function! s:session_filename() " {{{3
    if s:in_git_repo()
        return s:get_branch_name()
    else
        return 'Session.vim'
    endif
endfunction
" }}}2
" }}}1

" Public Functions: {{{1
" =================
function! EasySeshCreate() " {{{2
    let l:dir = s:session_dir()
    let l:filename = s:session_filename()
    let l:path = l:dir . '/' . l:filename

    if !isdirectory(l:dir)
        call mkdir(l:dir, 'p')
        if !isdirectory(l:dir)
            echoerr 'Cannot create directory' l:dir
            return
        endif
    endif

    if filewritable(l:dir) != 2
        echoerr 'Cannot write to:' l:dir
        return
    endif

    if !exists('g:this_easysesh')
        let g:this_easysesh = l:path
        execute 'mksession! ' . l:path
        echom 'EashSesh created:' l:path
    endif
endfunction

function! EasySeshUpdate() " {{{2
    if exists('g:this_easysesh')
        execute 'mksession! ' . g:this_easysesh
    endif
endfunction

function! EasySeshLoad(bang, ...) " {{{2
    " Don't load at start if arglist nonzero
    if !empty(a:1) && argc() != 0
        return
    endif

    let l:path = s:session_dir() . '/' . s:session_filename()

    if exists('g:this_easysesh')
        " Don't load if already loaded and not bang
        if !a:bang || l:path ==# g:this_easysesh
            echoerr 'EasySesh already loaded:' g:this_easysesh
            return
        else
            call EasySeshUpdate()
            echom 'Switching from ' . g:this_easysesh . ' to ' . l:path
            let g:this_easysesh = l:path
            execute 'source ' . l:path
            return
        endif
    else
        if filereadable(l:path)
            let g:this_easysesh = l:path
            execute 'source ' . l:path
            echom 'easysesh loaded:' l:path
        endif
    endif
endfunction

function! EasySeshDelete() " {{{2
    if exists('g:this_easysesh') && filereadable(g:this_easysesh)
        call delete(g:this_easysesh)
        echom 'EasySesh deleted:' g:this_easysesh
        unlet! g:this_easysesh
    endif
endfunction
" }}}1

" Commands: {{{1
" =========
command EasySeshCreate call EasySeshCreate()
command -bang EasySeshLoad call EasySeshLoad(<bang>0)
command EasySeshDelete call EasySeshDelete()
" }}}1

" Auto Commands: {{{1
" ==============
augroup EasySesh
    autocmd!
    autocmd VimLeavePre,BufEnter * call EasySeshUpdate()
    autocmd VimEnter * nested call EasySeshLoad(1, 1)
augroup END
