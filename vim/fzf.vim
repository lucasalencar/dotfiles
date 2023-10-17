" <CTRL-P> to find versioned files
noremap <C-p> :Files<CR>
inoremap <C-p> <Esc>:Files<CR>

noremap <leader><space> :Files<CR>
inoremap <leader><space> <Esc>:Files<CR>

" <Leader-F> to open Rg command
noremap <Leader>f :Rg<space>

" <Leader-SHIFT-F> to open Rg command with current word selected
nnoremap <silent> <Leader>F :Rg <C-R><C-W><CR>
vnoremap <silent> <Leader>F y:Rg <C-R>"<CR>
