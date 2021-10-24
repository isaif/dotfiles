vim.cmd([[
""""""""""""""""""""""""""""""""""""
""" Airline settings """""""""""""""
""""""""""""""""""""""""""""""""""""
"patched fonts
let g:airline_powerline_fonts = 1
"set default airline theme
let g:airline_theme='gruvbox'
" Enable airline for tabs

"enable modified detection
let g:airline_detect_modified=1

" defines whether the preview window should be excluded from have its window
" statusline modified (may help with plugins which use the preview window
" heavily)
"let g:airline_exclude_preview = 1

" Just show the filename (no path) in the tab
"let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline_inactive_collapse=1
"let g:airline_inactive_alt_sep=1
"let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0

let g:airline#extensions#nvimlsp#enabled = 1
let g:airline#extensions#nvimlsp#error_symbol = 'E'
let g:airline#extensions#nvimlsp#warning_symbol = 'W'
let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'warning', 'c'],
  \ [ 'x', 'y', 'z']
\ ]

" We don't need to see things like -- INSERT -- anymore
set noshowmode


]])
