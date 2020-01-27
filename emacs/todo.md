# Emacs TODO

- tick+N binding to bring project closer to next workspace
- tick+P binding to bring project closer to previous workspace
- Show flycheck warnings/errors in the echo line (not in the middle of the code)
- Start repl automatically when project is opened
- Show indicator that file is being evaled
- Handle eval for form under cursor (#'cider-eval-sexp-at-point is not an option)
- Use C-o/C-i to go back and forward cursor position (#'evil-jump-back is weird)
- After using project find with SPC-*, allow to filter by another search (like fzf in vim)
- Find a better terminal emulators alternatives
- Run cljfmt after saving a file 
  - https://github.com/hlissner/doom-emacs/blob/develop/init.example.el#L57
  - https://github.com/snoe/node-cljfmt
  - https://gitlab.com/konrad.mrozek/cljfmt-graalvm
