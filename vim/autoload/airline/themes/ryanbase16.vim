let g:airline#themes#ryanbase16#palette = {}

function! airline#themes#ryanbase16#refresh()

  let s:N1 = airline#themes#get_highlight2(['ErrorMsg', 'bg'], ['Statement', 'fg'], 'bold')
  let s:N2 = airline#themes#get_highlight('Folded')
  let s:N3 = airline#themes#get_highlight2(['NonText', 'fg'], ['ErrorMsg', 'bg'])

  let g:airline#themes#ryanbase16#palette.accents = {
        \ 'red': airline#themes#get_highlight('Boolean'),
        \ }

  let g:airline#themes#ryanbase16#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
  let g:airline#themes#ryanbase16#palette.normal_modified = {
        \ 'airline_c': airline#themes#get_highlight2(['PreProc', 'fg'], ['ErrorMsg', 'bg']),
        \ }

  let s:I1 = airline#themes#get_highlight('DiffAdd', 'bold')
  let s:I2 = s:N2
  let s:I3 = s:N3
  let g:airline#themes#ryanbase16#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
  let g:airline#themes#ryanbase16#palette.insert_modified = g:airline#themes#ryanbase16#palette.normal_modified

  let s:R1 = airline#themes#get_highlight2(['ErrorMsg', 'bg'], ['Delimiter', 'fg'], 'bold')
  let s:R2 = s:N2
  let s:R3 = s:N3
  let g:airline#themes#ryanbase16#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
  let g:airline#themes#ryanbase16#palette.replace_modified = g:airline#themes#ryanbase16#palette.normal_modified

  " Sometimes you want to mix and match colors from different groups, you can do
  " that with this method.
  let s:V1 = airline#themes#get_highlight2(['ErrorMsg', 'bg'], ['IncSearch', 'bg'], 'bold')
  let s:V2 = s:N2
  let s:V3 = s:N3
  let g:airline#themes#ryanbase16#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
  let g:airline#themes#ryanbase16#palette.visual_modified = g:airline#themes#ryanbase16#palette.normal_modified

  let s:IA = s:N2
  let g:airline#themes#ryanbase16#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
  let g:airline#themes#ryanbase16#palette.inactive_modified = g:airline#themes#ryanbase16#palette.normal_modified
endfunction

call airline#themes#ryanbase16#refresh()

