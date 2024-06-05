""" Markdown Preview: allows to preview markdown and PlantUML and Mermaid diagrams
" Toggle Markdown Preview
autocmd FileType markdown nmap <localleader>mp <Plug>MarkdownPreviewToggle

"" Open Markdown Preview into a new window using Arc browser
function OpenMarkdownPreviewArc (url)
  execute "silent ! open -a Arc " . a:url
endfunction

"" Open Markdown Preview into a new window using Chrome browser
function OpenMarkdownPreviewGoogleChrome (url)
  execute "silent ! open -a Google\\ Chrome -n --args --new-window " . a:url
endfunction

let g:mkdp_browserfunc = 'OpenMarkdownPreviewArc'
