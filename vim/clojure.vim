""" Clojure vim config

" Consider *.edn files as clojure
autocmd BufNewFile,BufRead *.edn setf clojure

""" easyalign

" Map to vertically align maps on Clojure
" This is not a flawless map, but will help most of the times
autocmd FileType clojure nmap <localleader>cma :startinsert<CR><CR><ESC>w==gaif<SPACE>kJ==


""" clojure refactors

" Order NS and avoid breaking lines that are too long
"autocmd FileType clojure nmap cn :%s/\(\[.*\)\n *\(:as\)\n *\(.*\]\)/\1 \2 \3/g<CR>

autocmd FileType clojure nmap crmv >e>eB<e
autocmd FileType clojure nmap crmk >e>egE<ew>e>egE<e

""" LSP Mappings
""" Create mappings using:
""" autocmd FileType clojure nmap <mapping> :call CocActionAsync('runCommand', '<command>')<CR>
""" <command> is found at coc-clojure readme
""" https://github.com/NoahTheDuke/coc-clojure#refactoring-commands

" Clean ns
autocmd FileType clojure nmap <localleader>cn :call CocActionAsync('runCommand', 'lsp-clojure-clean-ns')<CR>
" Add missing require
autocmd FileType clojure nmap <localleader>cam :call CocActionAsync('runCommand', 'lsp-clojure-add-missing-libspec')<CR>
" Drag pairs of symbols forward (used for maps or let bindings)
autocmd FileType clojure nmap <localleader>J :call CocActionAsync('runCommand', 'lsp-clojure-drag-forward')<CR>
" Drag pairs of symbols backwards (used for maps or let bindings)
autocmd FileType clojure nmap <localleader>K :call CocActionAsync('runCommand', 'lsp-clojure-drag-backward')<CR>

" Function to open project dependencies when finding references outside
" current project (e.g. gd into a common lib in a repo)
function! LoadClojureContent(uri)
    setfiletype clojure
    let content = CocRequest('clojure', 'clojure/dependencyContents', {'uri': a:uri})
    call setline(1, split(content, "\n"))
    setl nomodified readonly
endfunction
autocmd BufReadCmd  jar:file://*    call LoadClojureContent(expand("<afile>"))


" Clojure mapping to start a REPL based on vim-jack-in
autocmd FileType clojure nmap <localleader>rs :Lein<CR>

""" vim-clojure-static

" Avoid prefix rewriting when refactoring Clojure code
" Prefix rewriting example:
"   [service.namespace
"     [models]
"     [adapters]]
let g:clj_refactor_prefix_rewriting = 0

" Clojure indent keywords with 2 spaces (special cases)
" (ns service.namespace
"   (:require))
let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let', '^ns', '^provided', '^when-not', '^tabular', '^fn', '^flow', '^verify', '^try', '^catch', '^if-let', '^testing']
"let g:clojure_fuzzy_indent_patterns = ['.*']

" Clojure ident parameters when breaking lines with parenthesis
" (form
"  param1
"  param2)
let g:clojure_align_subforms = 1

" Set mapping to run current test under cursor
let g:conjure#client#clojure#nrepl#mapping#run_current_test = 'tt'
