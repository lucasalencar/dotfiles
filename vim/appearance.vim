""
"" Appearance
""

" Default theme configs
color molokai
set background=dark

""" lightline.vim
" previously colorscheme wombat
let g:lightline = {
      \ 'colorscheme': 'molokai',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'filetype' ],
      \              [ 'cocstatus', 'currentFunction' ]]
      \ },
      \ 'inactive': {
      \   'left': [ ['relativepath'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'relativepath': 'LightLineFilename',
      \   'cocstatus': 'coc#status',
      \   'currentFunction': 'CocCurrentFunction'
      \ },
      \ }

function! LightLineFilename()
  return expand('%')
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction
