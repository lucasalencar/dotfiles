" Go to definition remap (fireplace)
au FileType clojure map gd [<C-d>

" Go to definition on a new tab (fireplace)
au FileType clojure map gD <C-w>gd

" Find symbol under cursor usage (replant)
au FileType clojure map gu :ReplantFindSymbol<CR>

" Eval the whole file (fireplace)
au FileType clojure map cP :%Eval<CR>

" Run all tests in the current buffer (valid only for clojure.test) (fireplace)
au FileType clojure map cpt :Require<CR>:Eval (clojure.test/run-tests)<CR>

" Run all project tests (replant)
au FileType clojure map cpT :ReplantTestProject<CR>

" Rerun only failed project tests (replant)
au FileType clojure map cpR :ReplantRetestProject<CR>


""" easyalign

" Map to vertically align maps on Clojure
" This is not a flawless map, but will help most of the times
autocmd FileType clojure nmap crmm :startinsert<CR><CR><ESC>w==gaif<SPACE>kJ==


""" clojure refactor

" Order NS and avoid breaking lines that are too long
autocmd FileType clojure nmap cn :%s/\(\[.*\)\n *\(:as\)\n *\(.*\]\)/\1 \2 \3/g<CR>

autocmd FileType clojure nmap crmv >e>eB<e
autocmd FileType clojure nmap crmk >e>egE<ew>e>egE<e

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
