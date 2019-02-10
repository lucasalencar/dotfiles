""" General vim mappings

" Set leader and local leader key
" <space> is now the leader and local leader for all the files
let mapleader = " "
let maplocalleader = " "

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" Format entire file correcting identation
nnoremap <leader>fef :normal! gg=G``<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
nmap <leader>ee :e <C-R>=expand('%:h').'/'<cr>
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nmap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>

" New vertical pane, moving to new pane
nnoremap <leader>v <C-w>v<C-w>l
" New horizontal pane, moving to new pane
nnoremap <leader>s <C-w>s<C-w>j

" Close current panel
nnoremap <leader>q :q<CR>
" Close current tab
nnoremap <leader>Q :tabc<CR>

" Adjust viewports to the same size
map <leader>= <C-w>=

" Formats JSON files
map <leader>j :%!python -m json.tool<CR>

" Formats inline HTML files
map <leader>h :%s/<[^>]*>/\r&\r/g<CR>:g/^$/d<CR>:normal! gg=G``<CR>

" Formats inline EDN files (sort of, it breaks line when comma is found)
map <leader>ed :%s/,/&\r/g<CR>:normal! gg=G``<CR>

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" set text wrapping toggles
nmap <silent> \[ :set invwrap<CR>:set wrap?<CR>

" Toggle hlsearch with <leader>hs
nmap \] :set hlsearch! hlsearch?<CR>

" find git merge conflict markers
nmap <silent> <leader>gc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Shortcut to omnicomplete
imap <expr> <C-Space> "<C-x><C-o>"
