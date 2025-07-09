
lua require("plugin.init")

" Load pathogen plugins on startup:
execute pathogen#infect()

" * * * * * Great Mappings below: * * * * * "
"
" Mappings that make vim a lot cooler
"

let mapleader = "\<Space>"

set mouse=

"
" Mappings for working with multiple tabs:
"

" Open on a new tab with tt or tT:
noremap > :tab split<enter>
noremap <lt> :tab split<enter>:-tabmove<enter>

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
noremap <C-d> :tab split<enter>:term<enter>

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

" CodeCompanion

"noremap <Leader><Leader>h :CodeCompanionChat Toggle<enter>

" ALE Linter
noremap <Leader><Leader>n :ALENext<enter>

" FZF
nnoremap <Leader><Leader>p :FZF<enter>
vnoremap <Leader><Leader>p :FZF<enter>

" tig blame its not a plugin but very useful
nnoremap <Leader><Leader>b :execute ":!tig blame % +" . line('.')<enter>

" Dracula color scheme plugin:
color dracula
" Or if you don't want to install the dracula-vim plugin:
" color default

" * * * * * Personal configurations: * * * * * "

" differentiate spaces and tabs
set list
set listchars=eol:\ ,tab:ˑ\ ,trail:«

" customized tabs size:
set tabstop=2 shiftwidth=2 softtabstop=2
" autocmd FileType make setlocal noexpandtab

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

" Search the current word up or down but stop on the end of a function
nnoremap <leader>* viw"ly/^}\\|\<<C-r>l\><enter>
nnoremap <leader># viw"ly?^}\\|\<<C-r>l\><enter>

" Remove trailing spaces on save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun<Paste>
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
