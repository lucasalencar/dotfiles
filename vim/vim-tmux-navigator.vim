" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

" Normal mode mappings (g:tmux_navigator_no_mappings=1 disables the defaults)
nnoremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :<C-U>TmuxNavigatePrevious<cr>

" Terminal mode navigation (e.g. lazygit floating window)
" Problem: TmuxNavigateRight does `wincmd l` first, which lands on the vim buffer
" *behind* the float instead of switching to a tmux pane.
" Fix: call `tmux select-pane` directly, bypassing vim split navigation.
" On FocusGained, refocus the terminal window so the user lands back in lazygit.
if has('nvim')
  let s:terminal_win_id = v:null
  let s:came_from_terminal = 0

  function! s:TmuxPaneFromTerminal(direction)
    let s:terminal_win_id = win_getid()
    let s:came_from_terminal = 1
    let l:dirs = {'h': 'L', 'j': 'D', 'k': 'U', 'l': 'R'}
    silent call system('tmux select-pane -' . l:dirs[a:direction])
  endfunction

  function! s:RefocusTerminal()
    if s:came_from_terminal && s:terminal_win_id isnot v:null
          \ && win_id2win(s:terminal_win_id) != 0
      let s:came_from_terminal = 0
      call win_gotoid(s:terminal_win_id)
      startinsert
    endif
  endfunction

  augroup terminal_tmux_refocus
    autocmd!
    autocmd FocusGained * call s:RefocusTerminal()
  augroup END

  tnoremap <silent> <c-h> <Cmd>call <SID>TmuxPaneFromTerminal('h')<cr>
  tnoremap <silent> <c-j> <Cmd>call <SID>TmuxPaneFromTerminal('j')<cr>
  tnoremap <silent> <c-k> <Cmd>call <SID>TmuxPaneFromTerminal('k')<cr>
  tnoremap <silent> <c-l> <Cmd>call <SID>TmuxPaneFromTerminal('l')<cr>
endif
