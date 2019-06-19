" <CTRL-P> to find versioned files
noremap <C-p> :GFiles<CR>
inoremap <C-p> <Esc>:GFiles<CR>

" <Leader-F> to open Ag command
noremap <Leader>f :Ag<space>

" <Leader-SHIFT-F> to open Ag command with current word selected
nnoremap <silent> <Leader>F :Ag <C-R><C-W><CR>
vnoremap <silent> <Leader>F y:Ag <C-R>"<CR>
