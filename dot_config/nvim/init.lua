vim.cmd([[

" NEOVIM CONFIG

""""""""""""""""""""""""""""""""""""
""""""""Personal customization""""""
""""""""""""""""""""""""""""""""""""
" This option makes cursor as block cursor in nvim
set guicursor=

set relativenumber

"This will cause wrap to only wrap at the characters in the breakat
"setting, which defaults to space, tab, and small set of punctuation characters.
set linebreak

" Search files using fuzzy
set path+=**
set wildmenu

" Allow hidden buffers
set hidden

" Line length marker
"set colorcolumn=79

" Maintain undo history between sessions
" TODO can we share same undo dir with neovim and vim
set undofile
set undodir=~/.config/nvim/undodir

" Session directory
"let g:sessions_dir = '~/.vim/sessions'

"remove delay switching between insert and normal mode
set ttimeoutlen=10

" autoindent enable in vimgolf section
" smartindent will indent lines based on indent in surrounding lines
" useful when indent is not set for some filetypes
set smartindent

" enable filetype plugins
" useful to customize vim per filetype
" filetype on and filetype indent on are enabled in vimgolf section
" create a directory 'ftplugin' in .vim and add filetype.vim i.e.
" javascript.vim for javascript related settings and so on.
filetype plugin on

" When enter is pressed while cursor is between the {}
" Move closing curly brackets to new line
" and start a new line between them
inoremap <expr> <cr>
   \   getline(".") =~ '\S\s*{$'                 ? "<bs><cr>{<cr>}<esc>O"
   \ : getline('.') =~ '^\s*{$'                  ? "<cr>}<esc>O"
   \ : getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O"
   \ :                                             "<cr>"

" Highlight the 81st character / column in every row
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" movement in wrapped lines
" noremap j gj
" noremap k gk


""""""""""""""""""""""""""""""""""""
"" Sourcing init.lua """""""""""""
""""""""""""""""""""""""""""""""""""
" Requiring a nonexistent module or a module which contains syntax errors
" aborts the currently executing script. pcall() may be used to prevent errors.

lua <<EOF
require('saif')
EOF


""""""""""""""""""""""""""""""""""""
"" comma leader config """""""""""""
""""""""""""""""""""""""""""""""""""

" Open vimrc
nnoremap <F3> :call Openvimrc()<CR>
"nnoremap ,vr :source $MYVIMRC<CR>

" Replace word under cursor in file and line
nnoremap ,rf :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap ,rl :s/\<<C-r><C-w>\>//g<Left><Left>

" Copy all
nnoremap ,c ggVGy

" Uppercase a word
nnoremap ,u vaWUE


""""""""""""""""""""""""""""""""""""
""" Personal bindings """"""""""""""
""""""""""""""""""""""""""""""""""""

"map jj to esc
inoremap jj <Esc>

" Map space to leader and not changing it, the leader is still \
map <SPACE> <Leader>

" Clear highlights on hitting ESC twice
nnoremap <silent> <esc><esc> :nohlsearch<CR>

noremap <F2> :Lex<CR>


""""""""""""""""""""""""""""""""""""
""" Leader configuration """""""""""
""""""""""""""""""""""""""""""""""""

""" Clipboard copy/paste register"""
nnoremap <Leader>r "+
vnoremap <Leader>r "+

""" Fzf shortcut configuration """""
" nnoremap <Leader>b :Buffers<CR>
" nnoremap <Leader>e :Files<CR>
" nnoremap <Leader>ff :BLines<CR>
" nnoremap <Leader>fh :Helptags<CR>
" nnoremap <Leader>fo :History<CR>
" nnoremap <Leader>fp :Ag<CR>

""" Window management """"""""""""""
nnoremap <Leader>v <C-w>
nnoremap <Leader>c <C-w>c

" Zoom in and zoom out current window
noremap <Leader>zi <c-w>_ \| <c-w>\|
noremap <Leader>zo <c-w>=

""" Save file """"""""""""""""""""""
noremap <Leader>s :w<CR>
noremap <Leader>a :wa<CR>

""" Fugitive binding """""""""""""""
"nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Git<CR>
"nnoremap <leader>gc :Gcommit -v -q<CR>
"nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
"nnoremap <leader>ge :Gedit<CR>
"nnoremap <leader>gr :Gread<CR>
"nnoremap <leader>gw :Gwrite<CR><CR>
"nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
"nnoremap <leader>gp :Ggrep<leader>
"nnoremap <leader>gm :Gmove<leader>
"nnoremap <leader>gb :Git branch<leader>
"nnoremap <leader>go :Git checkout<leader>
"nnoremap <leader>gps :Dispatch! git push<CR>
"nnoremap <leader>gpl :Dispatch! git pull<CR>


""""""""""""""""""""""""""""""""""""
""" Vim's inbuilt completion """""""
""""""""""""""""""""""""""""""""""""
" ,, for <C-x><C-o>
" ,; for <C-n>
" ,: for <C-x><C-f>
" ,= for <C-c><C-l>
" the first item is selected
inoremap ,, <C-x><C-o><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
inoremap ,; <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
inoremap ,: <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
inoremap ,= <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>

" <Tab> and <S-Tab> complete the next and previous item
" the snipmate-related part is obviously not necessary for this to work
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : exists("g:loaded_snips") ? "\<C-r>=TriggerSnippet()\<CR>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : exists("g:loaded_snips") ? "\<C-r>=BackwardsSnippet()\<CR>" : "\<S-Tab>"


""""""""""""""""""""""""""""""""""""
""" Other plugin settings """"""""""
""""""""""""""""""""""""""""""""""""
" Taboo is able to remember tab names when you save the current 
" session but you are required to set the following option in your .vimrc file
set sessionoptions+=tabpages,globals


""""""""""""""""""""""""""""""""""""
""" Vimwiki settings """""""""""""""
""""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

" to search vimwiki
nnoremap <Leader>wf :VWS 


""""""""""""""""""""""""""""""""""""
""""""""VimGolf's .vimrc""""""""""""
""""""""""""""""""""""""""""""""""""
set nocompatible        " use vim defaults
set scrolloff=3         " keep 3 lines when scrolling
set ai                  " set auto-indenting on for programming

set showcmd             " display incomplete commands
set nobackup            " do not keep a backup file
set number              " show line numbers
set ruler               " show the current row and column

set hlsearch            " highlight searches
set incsearch           " do incremental searching

" Disabled as it makes cursor jump to opening bracket when
"closing bracket is entered
"set showmatch           " jump to matches when entering regexp
set ignorecase          " ignore case when searching
set smartcase           " no ignorecase if Uppercase char present

set visualbell t_vb=    " turn off error beep/flash
set novisualbell        " turn off visual bell

" make that backspace key work the way it should
"set backspace=indent,eol,start

" turn off user scripts, https://github.com/igrigorik/vimgolf/issues/129
"set runtimepath=$VIMRUNTIME

syntax on               " turn syntax highlighting on by default
filetype on             " detect type of file
filetype indent on      " load indent file for specific file type

"set t_RV=
" http://bugs.debian.org/608242,
" http://groups.google.com/group/vim_dev/browse_thread/thread/9770ea844cec3282


""""""""""""""""""""""""""""""""""""
""" Emment plugin settings """""""""
""""""""""""""""""""""""""""""""""""
"only enable normal mode functions.
"let g:user_emmet_mode='n'

" Enable just for html/css
let g:user_emmet_install_global = 1
autocmd FileType html,css EmmetInstall


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
"""Theme configuration""""""""""""""
""""""""""""""""""""""""""""""""""""

"let g:gruvbox_contrast_dark="hard"
""set default colorscheme
colorscheme gruvbox

set background=dark

"highlight current line
set cursorline

set t_Co=256


""""""""""""""""""""""""""""""""""""
""" Spell config """""""""""""""""""
""""""""""""""""""""""""""""""""""""

" spelling error highlight settings
hi clear SpellBad
hi SpellBad cterm=underline,bold ctermfg=red

"The following command will let us press CTRL-N or CTRL-P in
"insert-mode to complete the word we’re typing!
set complete+=kspell

" toggle spell on
nnoremap ,ts :set spell!<CR>


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

local vimp = require('vimp')

vimp.nnoremap(',vr',function()
  vimp.unmap_all()
  require("plenary.reload").reload_module("saif")
  dofile(vim.env.MYVIMRC)
  print("Reloaded vimrc!")
end)
