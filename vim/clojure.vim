""" easyalign

" Map to vertically align maps on Clojure
" This is not a flawless map, but will help most of the times
autocmd FileType clojure nmap <localleader>cam :startinsert<CR><CR><ESC>w==gaif<SPACE>kJ==


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

" Function to open project dependencies when finding references outside
" current project (e.g. gd into a common lib in a repo)
function! LoadClojureContent(uri)
    setfiletype clojure
    let content = CocRequest('clojure', 'clojure/dependencyContents', {'uri': a:uri})
    call setline(1, split(content, "\n"))
    setl nomodified readonly
endfunction
autocmd BufReadCmd  jar:file://*    call LoadClojureContent(expand("<afile>"))

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
