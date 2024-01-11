""" Markdown Preview: allows to preview markdown and PlantUML and Mermaid diagrams
" Toggle Markdown Preview
autocmd FileType markdown nmap <localleader>mp <Plug>MarkdownPreviewToggle


"" Open Markdown Preview into a new window
function OpenMarkdownPreview (url)
  execute "silent ! open -a Google\\ Chrome -n --args --new-window " . a:url
endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'

