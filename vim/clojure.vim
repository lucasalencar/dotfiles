""" vim-fireplace

" Go to definition remap
map gd [<C-d>
" Go to definition on a new tab
map gD <C-w>gd
" Eval the whole file
map cP :%Eval<CR>

""" easyalign

" Map to vertically align maps on Clojure
" This is not a flawless map, but will help most of the times
nmap crmm :startinsert<CR><CR><ESC>w==gaif<SPACE>kJ==