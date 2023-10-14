" <CTRL-P> to find versioned files
noremap <C-p> :Files<CR>
inoremap <C-p> <Esc>:Files<CR>

" <Leader-s> to open Rg command
noremap <Leader>s :Rg<space>

" <Leader-SHIFT-F> to open Rg command with current word selected
nnoremap <silent> <Leader>S :Rg <C-R><C-W><CR>
vnoremap <silent> <Leader>S y:Rg <C-R>"<CR>
