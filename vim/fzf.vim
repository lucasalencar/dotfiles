" <CTRL-p> to find versioned files
noremap <C-p> :Files<CR>
inoremap <C-p> <Esc>:Files<CR>

" <Leader-f> to open Rg command
noremap <Leader>f :Rg<space>

" <Leader-*> to open Rg command with current word selected
nnoremap <silent> <Leader>* :Rg <C-R><C-W><CR>
vnoremap <silent> <Leader>* y:Rg <C-R>"<CR>
