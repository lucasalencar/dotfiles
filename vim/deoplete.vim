let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1

" Close scratch when completion is done or exit insert mode
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Disable scratch
set completeopt-=preview
