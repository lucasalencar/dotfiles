;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(add-hook! clojure-mode #'lispyville-mode)

(after! lispyville
        (lispyville-set-key-theme
          '(additional
             additional-movement
             commentary
             operators
             slurp/barf-cp)))

; Add C-letters to navigate through emacs panes
; https://blog.kdheepak.com/emacsclient-and-tmux-split-navigation.html
(defun windmove-emacs-or-tmux(dir tmux-cmd)
  (interactive)
  (if (ignore-errors (funcall (intern (concat "windmove-" dir))))
    nil                       ;; Moving within emacs
    (shell-command tmux-cmd)) ;; At edges, send command to tmux
  )

; Move between windows with custom keybindings
(global-set-key (kbd "C-k")
   '(lambda () (interactive) (windmove-emacs-or-tmux "up"    "tmux select-pane -U")))
(global-set-key (kbd "C-j")
   '(lambda () (interactive) (windmove-emacs-or-tmux "down"  "tmux select-pane -D")))
(global-set-key (kbd "C-l")
   '(lambda () (interactive) (windmove-emacs-or-tmux "right" "tmux select-pane -R")))
(global-set-key (kbd "C-h")
   '(lambda () (interactive) (windmove-emacs-or-tmux "left"  "tmux select-pane -L")))
