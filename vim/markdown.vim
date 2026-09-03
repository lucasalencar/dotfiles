""" Markdown Preview: allows to preview markdown and PlantUML and Mermaid diagrams
" Toggle Markdown Preview
autocmd FileType markdown nmap <localleader>mp <Plug>MarkdownPreviewToggle

"" Open Markdown Preview using the default browser (respects macOS default, e.g. Zen)
function OpenMarkdownPreviewDefault (url)
  execute "silent ! open " . a:url
endfunction

"" Open Markdown Preview into a new window using Arc browser
function OpenMarkdownPreviewArc (url)
  execute "silent ! open -a Arc " . a:url
endfunction

"" Open Markdown Preview into a new window using Chrome browser
function OpenMarkdownPreviewGoogleChrome (url)
  execute "silent ! open -a Google\\ Chrome -n --args --new-window " . a:url
endfunction

let g:mkdp_browserfunc = 'OpenMarkdownPreviewDefault'

" Custom CSS to widen the preview area (defaults to a narrow, centered column)
let g:mkdp_markdown_css = expand('$DOTFILES_ROOT') . '/vim/markdown-preview.css'

""" Markdown Export: exports the current Markdown file to a PDF
""" saved next to the source file (requires pandoc + weasyprint + mermaid-filter)
function MarkdownExportToPdf()
  let l:dir = expand('%:p:h')
  let l:src = expand('%:t')
  let l:out = expand('%:t:r') . '.pdf'
  " mermaid-filter bundles its own outdated mmdc; point it at the working brew one instead.
  " PNG at a higher scale for quality: mermaid's SVG output uses <foreignObject> for
  " node labels, which weasyprint's SVG renderer doesn't support, so text disappears.
  let l:mmdc = exepath('mmdc')
  " Redirect stdout/stderr: any output here triggers vim's blocking
  " "Press ENTER to continue" prompt, hiding the echo/getchar below.
  execute 'silent ! cd ' . shellescape(l:dir) . ' && MERMAID_FILTER_CMD_MMDC=' . shellescape(l:mmdc) . ' MERMAID_FILTER_SCALE=3 pandoc ' . shellescape(l:src) . ' -F mermaid-filter --pdf-engine=weasyprint -o ' . shellescape(l:out) . ' > /tmp/markdown-export.log 2>&1 && rm -f mermaid-filter.err'
  redraw!
  if v:shell_error != 0
    echo 'Export failed (exit ' . v:shell_error . '). See /tmp/markdown-export.log'
    return
  endif
  let l:full_out = l:dir . '/' . l:out
  echo 'Exported to ' . l:full_out . ' -- press "o" to open, any other key to continue'
  if nr2char(getchar()) ==? 'o'
    execute 'silent ! open ' . shellescape(l:full_out)
  endif
endfunction

autocmd FileType markdown nmap <localleader>me :call MarkdownExportToPdf()<CR>
