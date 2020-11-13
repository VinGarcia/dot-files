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

" Goto next or previous tab:
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
map <Leader>d :ALEDetail<enter>
map <Leader>f :ALEGoToDefinitionInTab<enter>
map <Leader>i :ALEHover<enter>

" FZF
nnoremap <Leader><Leader> :FZF<enter>
vnoremap <Leader><Leader> :FZF<enter>

" JSX
let g:jsx_ext_required = 0

" Vim-Go Tools
let g:go_fmt_command = "goimports"
map <Leader>d :GoDef<enter>
map <Leader>b :GoDefPop<enter>

" Dracula color scheme plugin:
color dracula
" Or if you don't want to install the dracula-vim plugin:
" color default

" * * * * * Personal configurations: * * * * * "

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
vmap <Leader>y "wy
vmap <Leader>p "wp
map <Leader>p "wp

" Shortcut to go to next buffer when
" editing multiple files in a sequence:
map <Leader>n :n<enter>

" Shortcut to run macros on w and e:
map ; @w
map ´ @e

" Making alias for syntax highlighting by extension:
au BufRead,BufNewFile *.spy setfiletype javascript
au BufRead,BufNewFile *.ts setfiletype javascript

au BufRead,BufNewFile *.inc setfiletype cpp

au BufRead,BufNewFile *.kv setfiletype python

au BufRead,BufNewFile *.lock setfiletype json

au BufRead,BufNewFile *.spacemacs setfiletype lisp

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
