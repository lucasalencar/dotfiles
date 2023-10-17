" <CTRL-p> to find versioned files
noremap <C-p> :Files<CR>
inoremap <C-p> <Esc>:Files<CR>

" <CTRL-k> to find versioned files
noremap <C-k> :Files<CR>
inoremap <C-k> <Esc>:Files<CR>

" <Leader-f> to open Rg command
noremap <Leader>f :Rg<space>

" <Leader-SHIFT-F> to open Rg command with current word selected
nnoremap <silent> <Leader>F :Rg <C-R><C-W><CR>
vnoremap <silent> <Leader>F y:Rg <C-R>"<CR>
