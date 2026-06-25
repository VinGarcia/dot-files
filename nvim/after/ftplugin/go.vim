" ALE Linter
let g:ale_linters = {
\   'go': ['gobuild', 'golangci-lint'],
\}
let g:go_build_tags = "ksql_enable_kbuilder_experiment"

" Vim-Go configs
let g:go_fmt_command = "goimports"
map <C-i> :GoDef<enter>
map <C-o> :GoDefPop<enter>
map <buffer> <Leader>d :GoDef<enter>
map <buffer> <Leader>D :GoDefPop<enter>
" <Leader>i: list interface implementers and focus the results window.
" GoImplements opens the qf/loc list async, so we focus it by id once it appears.
function! s:FocusQf() abort
  for l:w in range(1, winnr('$'))
    if getwinvar(l:w, '&filetype') ==# 'qf'
      call win_gotoid(win_getid(l:w))
      return
    endif
  endfor
endfunction

function! s:GoImplementsFocus() abort
  augroup go_implements_focus
    autocmd!
    autocmd FileType qf ++once call timer_start(0, {_ -> s:FocusQf()})
  augroup END
  GoImplements
endfunction

map <buffer> <Leader>i :call <SID>GoImplementsFocus()<enter>
map <buffer> <Leader>c :GoCoverageToggle<enter>
map <buffer> <f9> :GoBuild<enter>
map <buffer> <Leader><Leader>d :call go#lsp#Exit()<enter>

" GoVim Govim configs
" nnoremap <buffer> <silent> <Leader>d :GOVIMGoToDef<enter>
" nnoremap <buffer> <silent> <Leader>b :GOVIMGoToPrevDef<enter>
" nnoremap <buffer> <silent> <Leader>i :GOVIMImplements<enter>

