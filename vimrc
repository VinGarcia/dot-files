" Load pathogen plugins on startup:
execute pathogen#infect()

" * * * * * Essential Commands: * * * * * "
"
" Commands that everyone should have on their .vimrc:
"

" Autodetect filetypes:
filetype plugin on
filetype indent on

" Set syntax highlighting:
syn on

" Incremental search:
set incsearch

" Show command on bottom right:
set showcmd

" Auto indent
set autoindent

" Setup the status bar on the bottom:
set laststatus=2

"
" Mappings for preventing common mistakes:
"

" Prevent typos (e.g. `:Q` or `:Wq` or `:WQ` will just work):
command Q q
command W w
command WQ wq
command Wq wq

" Stop that stupid window from popping up:
map q: :q
map K k


" * * * * * Great Mappings below: * * * * * "
"
" Mappings that make vim a lot cooler
"

" Map leader to space:
let mapleader = "\<Space>"

"
" Mappings for working with multiple tabs:
"

" Open on a new tab with tt or tT:
noremap tt :tab split<enter>
noremap tT :tab split<enter>:-tabmove<enter>

" Go to next or previous tab:
map <Leader>h :tabp<enter>
map <Leader>l :tabn<enter>

" Move tabs left and right:
noremap <Leader><C-h> :-tabmove<enter>
noremap <Leader><C-l> :+tabmove<enter>

"
" Cool features to have:
"

" Toggle to bash with <C-d>:
noremap <C-d> :sh<enter>

" Update the :sh command to open a login shell (useful when using rvm)
set shell=bash\ -l

" Force saving when file is opened read-only by accident:
map <Leader>s :w !sudo tee %<enter>

" Easily toogle tab size from 2 to 4 spaces:
map <Leader>, :set ts=2 sw=2 sts=2<enter>
map <Leader>. :set ts=4 sw=4 sts=4<enter>

"
" Restoring normal keyboard shortcuts:
"
" 1. ctrl+c copies
" 2. ctrl+v pastes
" 3. ctrl+s saves
" 4. ctrl+q closes
"
" Note: these mappings change block selection (ctrl+v)
" to ctrl+b so that you can use ctrl+v to paste.
"

" Necessary for allowing ctrl-q to quit and ctrl-s to save:
silent !stty -ixon > /dev/null 2>/dev/null

" Map visual block to <C-b>
" (makes more sense and frees <C-v> for pasting)
noremap <C-b> <C-v>
inoremap <C-b> <C-v>

" ctrl+c copies:
vmap <C-c> "+y

" Ctrl+v pastes:
map <C-v> "+p
imap <C-v> <esc><C-v>a

" ctrl-q quits
map <C-q> :q<enter>
imap <C-q> <esc><C-q>

" ctrl-s saves
map <C-s> :w<enter>
imap <C-s> <esc><C-s>a

" * * * * * Plugin Configurations: * * * * *

" ALE Linter
noremap <Leader><Leader>n :ALENext<enter>
let g:ale_linters = {
\   'go': ['gobuild'],
\}

" FZF
nnoremap <Leader><Leader>p :FZF<enter>
vnoremap <Leader><Leader>p :FZF<enter>

" tig blame its not a plugin but very useful
nnoremap <Leader><Leader>b :execute ":!tig blame % +" . line('.')<enter>

" JSX
let g:jsx_ext_required = 0

" Vim-Go configs
let g:go_fmt_command = "goimports"
map <Leader>d :GoDef<enter>
map <Leader>b :GoDefPop<enter>
map <Leader>c :GoCoverageToggle<enter>
map <f9> :GoBuild<enter>
map <Leader><Leader>d :call go#lsp#Exit()<enter>

" GoVim Govim configs
" nnoremap <buffer> <silent> <Leader>d :GOVIMGoToDef<enter>
" nnoremap <buffer> <silent> <Leader>b :GOVIMGoToPrevDef<enter>
" nnoremap <buffer> <silent> <Leader>i :GOVIMImplements<enter>

" Dracula color scheme plugin:
color dracula
" Or if you don't want to install the dracula-vim plugin:
" color default

" * * * * * Personal configurations: * * * * * "

" differentiate spaces and tabs
set list

" customized tabs size:
set expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType make setlocal noexpandtab

" Disable the single buffer command, to prevent it from being
" pressed by accident:
map <C-w>o <Nop>

" Shortcut to change current buffer to adjacent file:
map <C-p> :e <C-r>%

" Skip the C-w when changing panes in multi-view vim:
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Copy on register w with <Space>y
" paste with <Space>p
" (This is good when you don't want to
" loose your copy when deleting)
vmap <Leader>y "yy
vmap <Leader>p "yp
map <Leader>p "yp

" Shortcut to go to next buffer when
" editing multiple files in a sequence:
map <Leader>n :n<enter>

" Shortcut to run macros on w and e:
map ; @w
map ´ @e

" Searchs vertically downward for the next non-blank character:
nnoremap dc /\%<C-R>=virtcol(".")<CR>v\S<CR>

" Searchs vertically upward for the next non-blank character:
nnoremap cd ?\%<C-R>=virtcol(".")<CR>v\S<CR>

" Search upwards for the first line starting with a non-space character.
nnoremap 1ff ?\%1v\S<cr>

nnoremap <leader>* viw"ly/^}\\|\<<C-r>l\><enter>
nnoremap <leader># viw"ly?^}\\|\<<C-r>l\><enter>

" Increase maxmempattern default value from 1000 to 4000
" so that syntax highlight won't break on big Go files.
set maxmempattern=4000

" Remove trailing spaces on save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun<Paste>
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Change vim/vimdiff highlight colors to better ones:
hi Search cterm=NONE ctermfg=grey ctermbg=blue
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
