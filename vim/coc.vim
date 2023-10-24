" Coc (Plugin to integrate with Language Servers)

" Extensions to be installed when coc loads
let g:coc_global_extensions = [
      \'coc-markdownlint',
      \'coc-highlight',
      \'coc-go',
      \'coc-python',
      \'coc-flutter',
      \'coc-git',
      \'coc-json',
      \'coc-clojure',
      \'coc-vimlsp'
      \]

" Set custom config file for coc
let g:coc_config_home = '~/.dotfiles/vim'

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

""" Mappings

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <localleader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <localleader>a  <Plug>(coc-format-selected)
nmap <localleader>a  <Plug>(coc-format)
xmap <localleader>f  <Plug>(coc-format-selected)
nmap <localleader>f  <Plug>(coc-format)

" Applying code actions to the selected code block
" Example: `<localleader>cap` for current paragraph
xmap <localleader>c  <Plug>(coc-codeaction-selected)
nmap <localleader>c  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <localleader>cc  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <localleader>cb  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
"nmap <localleader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Vim script LSP configs
" Enable document highlight
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]
