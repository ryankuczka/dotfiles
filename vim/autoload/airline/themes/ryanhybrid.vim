" vim-airline companion theme of Hybrid
" (https://github.com/w0ng/vim-hybrid)

let g:airline#themes#ryanhybrid#palette = {}

function! airline#themes#ryanhybrid#refresh()
    let s:N1 = airline#themes#get_highlight2(['Search', 'fg'], ['DiffAdd', 'bg'])
    let s:N2 = airline#themes#get_highlight('PMenuSel')
    let s:N3 = airline#themes#get_highlight('CursorLine')
    let g:airline#themes#ryanhybrid#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

    let modified_group = airline#themes#get_highlight2(['Search', 'bg'], ['CursorLine', 'bg'])
    let g:airline#themes#ryanhybrid#palette.normal_modified = {
                \ 'airline_c': modified_group
                \ }

    let warning_group = airline#themes#get_highlight2(['Function', 'fg'], ['Normal', 'bg'])
    let g:airline#themes#ryanhybrid#palette.normal.airline_warning = warning_group
    let g:airline#themes#ryanhybrid#palette.normal_modified.airline_warning = warning_group

    let s:I1 = airline#themes#get_highlight('Search')
    let s:I2 = s:N2  " airline#themes#get_highlight2(['Text', 'fg'], ['SpellLocal', 'bg'], 'bold')
    let s:I3 = s:N3  " airline#themes#get_highlight2(['Text', 'fg'], ['SpellCap', 'bg'], 'bold')
    let g:airline#themes#ryanhybrid#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
    let g:airline#themes#ryanhybrid#palette.insert_modified = g:airline#themes#ryanhybrid#palette.normal_modified
    let g:airline#themes#ryanhybrid#palette.insert.airline_warning = g:airline#themes#ryanhybrid#palette.normal.airline_warning
    let g:airline#themes#ryanhybrid#palette.insert_modified.airline_warning = g:airline#themes#ryanhybrid#palette.normal_modified.airline_warning

    let s:R1 = airline#themes#get_highlight2(['Search', 'fg'], ['DiffChange', 'bg'])
    let s:R2 = s:N2
    let s:R3 = s:N3
    let g:airline#themes#ryanhybrid#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
    let replace_group = airline#themes#get_highlight('SpellRare')
    let g:airline#themes#ryanhybrid#palette.replace_modified = g:airline#themes#ryanhybrid#palette.normal_modified
    let g:airline#themes#ryanhybrid#palette.replace.airline_warning = g:airline#themes#ryanhybrid#palette.normal.airline_warning
    let g:airline#themes#ryanhybrid#palette.replace_modified.airline_warning = g:airline#themes#ryanhybrid#palette.replace_modified.airline_warning

    let s:V1 = airline#themes#get_highlight('DiffDelete')
    let s:V2 = s:N2  " airline#themes#get_highlight2(['Text', 'fg'], ['DiffDelete', 'bg'], 'bold')
    let s:V3 = s:N3  " airline#themes#get_highlight2(['Text', 'fg'], ['Error', 'bg'], 'bold')
    let g:airline#themes#ryanhybrid#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
    let g:airline#themes#ryanhybrid#palette.visual_modified = g:airline#themes#ryanhybrid#palette.normal_modified
    let g:airline#themes#ryanhybrid#palette.visual.airline_warning = g:airline#themes#ryanhybrid#palette.normal.airline_warning
    let g:airline#themes#ryanhybrid#palette.visual_modified.airline_warning = g:airline#themes#ryanhybrid#palette.normal_modified.airline_warning

    let s:IA = airline#themes#get_highlight('StatusLineNC')
    let g:airline#themes#ryanhybrid#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
    let g:airline#themes#ryanhybrid#palette.inactive_modified = {
                \ 'airline_c': [ modified_group[0], '', modified_group[2], '', '' ]
                \ }

    let g:airline#themes#ryanhybrid#palette.accents = {
                \ 'red': airline#themes#get_highlight('Constant'),
                \ }

endfunction

call airline#themes#ryanhybrid#refresh()
