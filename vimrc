" Make sure plugins are put to use:
execute pathogen#infect()

" fox (minhas) configurations:

" Disable the single buffer command, to prevent it from being
" pressed by accident:
map <C-w>o <Nop>

" Shortcut to change current buffer to adjacent file:
map <C-p> :e <C-r>%

" Making alias for syntax highlighting by extension:
au BufRead,BufNewFile *.talk setfiletype javascript
au BufRead,BufNewFile *.tk setfiletype javascript
au BufRead,BufNewFile *.sp setfiletype javascript
au BufRead,BufNewFile *.spy setfiletype javascript
au BufRead,BufNewFile *.sol setfiletype javascript
au BufRead,BufNewFile *.ts setfiletype javascript

au BufRead,BufNewFile *.inc setfiletype cpp

au BufRead,BufNewFile *.kv setfiletype python

au BufRead,BufNewFile *.lock setfiletype json

au BufRead,BufNewFile *.spacemacs setfiletype lisp

" * * * * * Great Mappings below: * * * * * "

" Map leader to space:
let mapleader = "\<Space>"

" Open on a new tab with tt:
" (Useful for maximizing a window when working
" with multiple files in a split screen)
noremap tt :tab split<enter>
noremap tT :tab split<enter>:-tabmove<enter>

" Goto next or previous tab:
map <Leader>h :tabp<enter>
map <Leader>l :tabn<enter>

" Move tabs left and right:
noremap <Leader><C-h> :-tabmove<enter>
noremap <Leader><C-l> :+tabmove<enter>

" Skip the C-w when changing panes in multi-view vim:
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Prevent typos:
command Q q
command W w
command WQ wq
command Wq wq

" Stop that stupid window from popping up:
map q: :q
map K k

" Toggle to bash with <C-d>:
noremap <C-d> :sh<enter>

" Set syntax highlighting:
syn on

" Incremental search:
set incsearch

" Show command on bottom right:
set showcmd

" Auto indent
set autoindent

" customized tabs:
set expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType make setlocal noexpandtab

" Toogle tab size from 2 to 4 spaces:
map <Leader>, :set ts=2 sw=2 sts=2<enter>
map <Leader>. :set ts=4 sw=4 sts=4<enter>

" Use color scheme `dracula` (looks a lot better)
color dracula
" Or if you don't want to install the dracula-vim plugin:
" color default

" For allowing ctrl-q to quit and ctrl-s to save:
silent !stty -ixon > /dev/null 2>/dev/null

" Make ctrl-q quit, and ctrl-s save
map <C-q> :q<enter>
map <C-s> :w<enter>
imap <C-s> <esc><C-s>a
imap <C-q> <esc><C-q>

" Copy on register w with <Space>y
" paste with <Space>p
" (This is good when you don't want to
" loose your copy when deleting)
vmap <Leader>y "wy
vmap <Leader>p "wp
map <Leader>p "wp

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

" * * * * * Macros that might not fit all users: * * * * * "


" Shortcut to run macros on w and e:
map ; @w
map ´ @e

" Map visual block to <C-b>
" (makes more sense and frees <C-v> for pasting)
noremap <C-b> <C-v>
inoremap <C-b> <C-v>

" Ctrl+c copies:
vmap <C-c> "+y

" Ctrl+v paste:
map <C-v> "+p
imap <C-v> <esc><C-v>a

" Force saving when file is opened read-only by accident:
map <Leader>s :w !sudo tee %<enter>

" vim-airline configurations
" (Add useful information on the bottom of the editor):
set t_Co=256
let g:Powerline_symbols = "fancy"
let g:airline_powerline_fonts = 1
set laststatus=2

" * * * * * End of Great Mappings * * * * * "

filetype on
filetype plugin on
filetype indent on

" * * * * * Start ToggleComment(): * * * * * "

let s:comment_map = {
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "rs": '\/\/',
    \   "go": '\/\/',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "scala": '\/\/',
    \   "php": '\/\/',
    \   "po": '#',
    \   "python": '#',
    \   "ruby": '#',
    \   "make": '#',
    \   "sh": '#',
    \   "desktop": '#',
    \   "fstab": '#',
    \   "conf": '#',
    \   "profile": '#',
    \   "bashrc": '#',
    \   "bash_profile": '#',
    \   "mail": '>',
    \   "eml": '>',
    \   "bat": 'REM',
    \   "ahk": ';',
    \   "vim": '"',
    \   "tex": '%',
    \ }

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " "
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction

nnoremap <C-_> :call ToggleComment()<enter>
vnoremap <C-_> :call ToggleComment()<enter>

" nnoremap <C-=> :call ToggleComment()<enter>
" vnoremap <C-=> :call ToggleComment()<enter>

nnoremap <Leader>j :call ToggleComment()<enter>
vnoremap <Leader>j :call ToggleComment()<enter>
nnoremap <Leader>k :call ToggleComment()<enter>
vnoremap <Leader>k :call ToggleComment()<enter>

nnoremap <C-]> :call ToggleComment()<enter>
vnoremap <C-]> :call ToggleComment()<enter>

" * * * * * End ToggleComment() * * * * * "

" Shortcut to go to next buffer when
" editing multiple files in a sequence:
map <Leader>n :n<enter>

" Go to next incorrect word when spell checker is on:
" map <Leader>m ]s
" map <Leader>M [s

" Enable mouse interaction
" (useful but cause problems to copy with the right click):
" set mouse=a

" * * * * * Start Plugins * * * * *

" ALE Linter
map <Leader>d :ALEDetail<enter>
map <Leader>f :ALEGoToDefinitionInTab<enter>
map <Leader>i :ALEHover<enter>

" FZF
nnoremap <Leader><Leader> :FZF<enter>
vnoremap <Leader><Leader> :FZF<enter>

" JSX
let g:jsx_ext_required = 0
