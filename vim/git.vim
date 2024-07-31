""" Mappings for git

" Command to fix vim-rhubarb GBrowse
command! -bar -nargs=1 Browse silent! exe '!open' shellescape(<q-args>, 1)

" Git open file at github
nmap <leader>go :GBrowse<CR>

" Git open file at github (selected lines)
vmap <leader>go :GBrowse<CR>

" Setup mapping to call :LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>
