" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Map to vertically align maps on Clojure
" This is not a flawless map, but will help most of the times
nmap crmm :startinsert<CR><CR><ESC>w==gaif<SPACE>kJ==
