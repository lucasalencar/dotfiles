""" Clojure vim config

" Consider *.edn files as clojure
autocmd BufNewFile,BufRead *.edn setf clojure

function ClojureMappings()
    """ Mappings related to code refactor

    " Vertically align maps on Clojure
    " This is not a flawless, but will help most of the times
    " Uses easyalign plugin
    nmap <localleader>cma :startinsert<CR><CR><ESC>w==gaif<SPACE>kJ==

    " Order NS and avoid breaking lines that are too long
    "nmap cn :%s/\(\[.*\)\n *\(:as\)\n *\(.*\]\)/\1 \2 \3/g<CR>

    nmap <localleader>crmv >e>eB<e
    nmap <localleader>crmk >e>egE<ew>e>egE<e
endfunction
autocmd FileType clojure call ClojureMappings()

function ClojureLSPMappings()
    """ Create mappings using:
    """ nmap <mapping> :call CocActionAsync('runCommand', '<command>')<CR>
    """ <command> is found at coc-clojure readme
    """ https://github.com/NoahTheDuke/coc-clojure#refactoring-commands

    " Clean ns
    nmap <localleader>cn :call CocActionAsync('runCommand', 'lsp-clojure-clean-ns')<CR>
    " Add missing require
    nmap <localleader>cam :call CocActionAsync('runCommand', 'lsp-clojure-add-missing-libspec')<CR>
    " Drag pairs of symbols forward (used for maps or let bindings)
    nmap <localleader>J :call CocActionAsync('runCommand', 'lsp-clojure-drag-forward')<CR>
    " Drag pairs of symbols backwards (used for maps or let bindings)
    nmap <localleader>K :call CocActionAsync('runCommand', 'lsp-clojure-drag-backward')<CR>
    " Thread first all
    nmap <localleader>ctf :call CocActionAsync('runCommand', 'lsp-clojure-thread-first-all')<CR>
    " Thread last all
    nmap <localleader>ctl :call CocActionAsync('runCommand', 'lsp-clojure-thread-last-all')<CR>
    " Thread unwind all
    nmap <localleader>ctua :call CocActionAsync('runCommand', 'lsp-clojure-unwind-all')<CR>
    " Thread unwind
    nmap <localleader>ctuu :call CocActionAsync('runCommand', 'lsp-clojure-unwind-thread')<CR>
endfunction
autocmd FileType clojure call ClojureLSPMappings()

" Function to open project dependencies when finding references outside
" current project (e.g. gd into a lib in a repo)
function! LoadClojureContent(uri)
    setfiletype clojure
    let content = CocRequest('clojure', 'clojure/dependencyContents', {'uri': a:uri})
    call setline(1, split(content, "\n"))
    setl nomodified readonly
endfunction
autocmd BufReadCmd jar:file://* call LoadClojureContent(expand("<afile>"))


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

" Enable Rainbow parenthesis
let g:rainbow_active = 1

" Set mapping to run current test under cursor
let g:conjure#client#clojure#nrepl#mapping#run_current_test = 'tt'

let g:conjure#client#clojure#nrepl#test#current_form_names = ['deftest', 'defspec', 'defflow']
