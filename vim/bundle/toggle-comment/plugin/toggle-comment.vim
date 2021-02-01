" This file declares a function to toggle comments on several languages:

let s:comment_map = {
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "proto": '\/\/',
    \   "rs": '\/\/',
    \   "go": '\/\/',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "typescript": '\/\/',
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
    \   "elixir": '#',
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
