setlocal noexpandtab

map <Leader>d :ALEGoToDefinition<enter>
" map <Leader>f <Esc>ma<CR>:%!npx prettier %<CR>:%!npx eslint --stdin --fix-dry-run --max-warnings=-1 --report-unused-disable-directives -o /tmp/eslint && cat /tmp/eslint <CR>`a
map <Leader>f <Esc>ma<CR>:%!npx prettier %<CR>`a

" autocmd bufwritepost *.ts silent !npx eslint --cache --cache-location node_modules/.cache/eslint/ --ext .js,.jsx,.ts,.tsx --fix --max-warnings=-1 --report-unused-disable-directives %
" autocmd BufWrite *.ts silent :exec normal "<Esc>ma<CR>:%!npx prettier %<CR>`a"
