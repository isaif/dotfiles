--##################################################################--
-- Sourcing lua files
--##################################################################--
-- Requiring a nonexistent module or a module which contains syntax errors
-- aborts the currently executing script. pcall() may be used to prevent errors
require('saif')

--##################################################################--
-- vim native
--##################################################################--
vim.cmd([[

" Highlight the 81st character / column in every row
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" beautiful folds
" function FoldText()
" 	let line = getline(v:foldstart)
" 	let numOfLines = v:foldend - v:foldstart
" 	let fillCount = winwidth('%') - len(line) - len(numOfLines) - 14
" 	return line . '  ' . repeat('.', fillCount) . ' (' . numOfLines . ' L)'
" endfunction
" set foldtext=FoldText()
" set fillchars=fold:\  " removes trailing dots. Mind that there
" is a whitespace after the \!

""""""""""""""""""""""""""""""""""""
""" Vimwiki settings """""""""""""""
""""""""""""""""""""""""""""""""""""
" TODO: change wiki mapping prefix to k and window management prefix to w
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

" to search vimwiki
nnoremap <Leader>wf :VWS 

""""""""""""""""""""""""""""""""""""
""" Firenvim settings """"""""""""""
""""""""""""""""""""""""""""""""""""
let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }

" TODO add whatever status line being used
" If the instance is firenvim disable airline and
" make status line simple
if exists('g:started_by_firenvim')
	let g:loaded_airline = 1
	set laststatus=0
endif

""""""""""""""""""""""""""""""""""""
""" Scripts """"""""""""""""""""""""
""""""""""""""""""""""""""""""""""""

" Configure VIM to run chezmoi apply whenever you save a dotfile while inside
" the source directory
autocmd BufWritePost ~/.local/share/chezmoi/* execute "!chezmoi apply --source-path %" | redraw!
" All dotfiles are being edit at source directory of chezmoi
" therefore above code works expect vimrc file which is edited in target
" directory i.e. ~/.vimrc
" Since I am using a script to open vimrc it needs to be readded by chezmoi
" This is a init.vim file so init.vim
autocmd BufWritePost ~/.config/nvim/init.vim execute "!chezmoi re-add --source-path %" | redraw!


" delete hidden buffers
function! DeleteHiddenBuffers()
  let tpbl=[]
  let closed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let closed += 1
    endif
  endfor
  echo "Closed ".closed." hidden buffers"
endfunction

command! Dbuf :call DeleteHiddenBuffers()


" function to toggle vimrc file in a tab
function! Openvimrc()
  " check if current tab has vimrc
  let l:buf_win_number = bufwinnr("init.lua")
  " if window exists then close it
  if buf_win_number > 0
    exe buf_win_number . "wincmd c" 
  else
    " Check if vimrc is opened in another tab
    let l:vim_buffer_number = bufnr("init.lua")
    let l:win_id_list = win_findbuf(vim_buffer_number)
    " if true then switch to it else open it in new tab
    if len(win_id_list) != 0
      let l:winid = win_id_list[0]
      call win_gotoid(winid)
    else 
      :tabnew $MYVIMRC
    endif
  endif
endfunction


]])
