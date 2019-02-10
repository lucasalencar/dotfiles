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
vmap ‘ >gv
vmap “ <gv
nmap ‘ >>
nmap “ <<
omap ‘ >>
omap “ <<
imap ‘ <Esc>>>i
imap “ <Esc><<i

" Bubble single lines
" ALT + j => bubble down
" ALT + k => bubble up
nmap ˚ [e
nmap ∆ ]e
vmap ˚ [egv
vmap ∆ ]egv

" Map ALT-# to switch tabs
" Ex: ALT + 1 => goes to tab 1
" Ex: ALT + 2 => goes to tab 2
map  º 0gt
imap º <Esc>0gt
map  ¡ 1gt
imap ¡ <Esc>1gt
map  ™ 2gt
imap ™ <Esc>2gt
map  £ 3gt
imap £ <Esc>3gt
map  ¢ 4gt
imap ¢ <Esc>4gt
map  ∞ 5gt
imap ∞ <Esc>5gt
map  § 6gt
imap § <Esc>6gt
map  ¶ 7gt
imap ¶ <Esc>7gt
map  • 8gt
imap • <Esc>8gt
map  ª 9gt
imap ª <Esc>9gt

" Map ALT + SHIFT + <direction> to switch tabs
" ALT + SHIFT + [ => previous tab
noremap ’ :tabnext<CR>
" ALT SHIFT + ] => next tab
noremap ” :tabprevious<CR>

" ALT + = => Increase current split size
map ≠ 5<C-w>>
" ALT + - => Decrease current split size
map – 5<C-w><

" <ALT-P> to find through all files inside directory
noremap π :Files<CR>
inoremap π <Esc>:Files<CR>

" Maps to comment single lines easily
" ALT + / => comments current line
map ÷ <plug>NERDCommenterToggle
" ALT + SHIFT + / => comments current line and goes to next one
map ¿ <plug>NERDCommenterToggle<CR>
