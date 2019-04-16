""" vim-fireplace

" Go to definition remap
autocmd FileType clojure map gd [<C-d>
" Go to definition on a new tab
autocmd FileType clojure map gD <C-w>gd
" Eval the whole file
autocmd FileType clojure map cP :%Eval<CR>

""" easyalign

" Map to vertically align maps on Clojure
" This is not a flawless map, but will help most of the times
autocmd FileType clojure nmap crmm :startinsert<CR><CR><ESC>w==gaif<SPACE>kJ==

""" clojure refactor

" Order NS and avoid breaking lines that are too long
autocmd FileType clojure nmap cn :%s/\(\[.*\)\n *\(:as\)\n *\(.*\]\)/\1 \2 \3/g<CR>

autocmd FileType clojure nmap crmv >e>eB<e
autocmd FileType clojure nmap crmk >e>egE<ew>e>egE<e
