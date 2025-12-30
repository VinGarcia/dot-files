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
map <buffer> <Leader>c :GoCoverageToggle<enter>
map <buffer> <f9> :GoBuild<enter>
map <buffer> <Leader><Leader>d :call go#lsp#Exit()<enter>

" GoVim Govim configs
" nnoremap <buffer> <silent> <Leader>d :GOVIMGoToDef<enter>
" nnoremap <buffer> <silent> <Leader>b :GOVIMGoToPrevDef<enter>
" nnoremap <buffer> <silent> <Leader>i :GOVIMImplements<enter>

