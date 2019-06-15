" <CTRL-P> to find versioned files
noremap <C-p> :GFiles<CR>
inoremap <C-p> <Esc>:GFiles<CR>

" <Leader-F> to open Rg command
noremap <Leader>f :Rg<space>

" <Leader-SHIFT-F> to open Rg command with current word selected
nnoremap <silent> <Leader>F :Rg <C-R><C-W><CR>
vnoremap <silent> <Leader>F y:Rg <C-R>"<CR>
