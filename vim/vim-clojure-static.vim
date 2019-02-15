" Avoid prefix rewriting when refactoring Clojure code
" Prefix rewriting example:
"   [service.namespace
"     [models]
"     [adapters]]
let g:clj_refactor_prefix_rewriting = 0

" Clojure indent keywords with 2 spaces (special cases)
" (ns service.namespace
"   (:require))
let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let', '^ns', '^provided', '^when-not', '^tabular', '^fn', '^flow', '^verify', '^try', '^catch', '^if-let']
"let g:clojure_fuzzy_indent_patterns = ['.*']

" Clojure ident parameters when breaking lines with parenthesis
" (form
"  param1
"  param2)
let g:clojure_align_subforms = 1
