""" Mappings for MacOS option key.
" On MacOS, when you press any other key with option pressed, it sends a
" unicode character.
" These mapping use this unicode characters to perform actions on vim.
"
" They are just useful when the terminal used accepts option+key characters
" being sent.
"
" Example: MacOS Terminal.app and iTerm 2 accepts these kind of mappings but
" Kitty terminal avoids it, even though you can set a config that makes it
" accept it.

" Map alt-[ and alt-] to indenting or outdenting
" while keeping the original selection in visual mode
" ALT + ] => indent to right
" ALT + [ => indent to left
nmap <M-]> >>
nmap <M-[> <<
vmap <M-]> >gv
vmap <M-[> <gv
omap <M-]> >>
omap <M-[> <<
imap <M-]> <Esc>>>i
imap <M-[> <Esc><<i

" Bubble single lines
" ALT + j => bubble down
" ALT + k => bubble up
nmap <M-k> [e
nmap <M-j> ]e
vmap <M-k> [egv
vmap <M-j> ]egv

" Map ALT-# to switch tabs
" Ex: ALT + 1 => goes to tab 1
" Ex: ALT + 2 => goes to tab 2
map  <M-0> 0gt
imap <M-0> <Esc>0gt
map  <M-1> 1gt
imap <M-1> <Esc>1gt
map  <M-2> 2gt
imap <M-2> <Esc>2gt
map  <M-3> 3gt
imap <M-3> <Esc>3gt
map  <M-4> 4gt
imap <M-4> <Esc>4gt
map  <M-5> 5gt
imap <M-5> <Esc>5gt
map  <M-6> 6gt
imap <M-6> <Esc>6gt
map  <M-7> 7gt
imap <M-7> <Esc>7gt
map  <M-8> 8gt
imap <M-8> <Esc>8gt
map  <M-9> 9gt
imap <M-9> <Esc>9gt

" ALT + = => Increase current split size
map <M-=> 5<C-w>>
" ALT + - => Decrease current split size
map <M--> 5<C-w><

" <ALT-P> to find through all files inside directory
noremap π :Files<CR>
inoremap π <Esc>:Files<CR>

" Maps to comment single lines easily
" ALT + / => comments current line
map <M-/> <plug>NERDCommenterToggle
" ALT + SHIFT + / => comments current line and goes to next one
map <M-?> <plug>NERDCommenterToggle<CR>
