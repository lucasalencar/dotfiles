;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq doom-theme 'doom-one)

;; font
(setq doom-font (font-spec :family "Hack" :size 13)
      doom-big-font-increment 4
      doom-unicode-font (font-spec :family "DejaVu Sans"))

;; set localleader
(setq doom-localleader-key "m")

;; enable minibuffer to work correctly in evil mode
;; exit minibuffer with ESC
(setq evil-collection-setup-minibuffer t)

;; set window title "[project] filename"
(setq frame-title-format
      (setq icon-title-format
            '(""
              (:eval
               (format "[%s] " (projectile-project-name)))
              "%b")))

;; Mouse interaction
(when (eq window-system nil)
    (xterm-mouse-mode t))

;; Disable confirmation message on exit
(setq confirm-kill-emacs nil)

;; set emacs to startup with maximized window
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Initialize emacs with system $PATH (Mac issue)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; hl-fill-column
(add-hook! hl-fill-column-mode
  (set-face-attribute 'hl-fill-column-face nil
                      :background (doom-color 'red)
                      :foreground (doom-color 'fg)))

;; Modeline

(setq doom-modeline-persp-name t) ;; Shows project name in modeline

;; Workspaces + windows operations

(map!
 ;; Select windows
 :m "C-h" #'evil-window-left
 :m "C-l" #'evil-window-right
 :m "C-j" #'evil-window-down
 :m "C-k" #'evil-window-up

 ;; Move windows
 :m "C-S-h" #'+evil/window-move-left
 :m "C-S-j" #'+evil/window-move-down
 :m "C-S-k" #'+evil/window-move-up
 :m "C-S-l" #'+evil/window-move-right

 (:when (featurep! :ui workspaces)
   (:prefix "`"
     :desc "Next workspace (tmux like)"
     :n "n" #'+workspace/switch-right

     :desc "Previous workspace (tmux like)"
     :n "p" #'+workspace/switch-left

     :desc "Switch to different project (tmux like)"
     :n "P" #'projectile-switch-project

     :desc "Close current window (tmux like)"
     :n "x" #'+workspace/close-window-or-workspace

     ;; switch workspaces by index (tmux like)
     :n "1"  #'+workspace/switch-to-0
     :n "2"  #'+workspace/switch-to-1
     :n "3"  #'+workspace/switch-to-2
     :n "4"  #'+workspace/switch-to-3
     :n "5"  #'+workspace/switch-to-4
     :n "6"  #'+workspace/switch-to-5
     :n "7"  #'+workspace/switch-to-6
     :n "8"  #'+workspace/switch-to-7
     :n "9"  #'+workspace/switch-to-8)

   ;; switch workspaces by index
   :g "s-1" #'+workspace/switch-to-0
   :g "s-2" #'+workspace/switch-to-1
   :g "s-3" #'+workspace/switch-to-2
   :g "s-4" #'+workspace/switch-to-3
   :g "s-5" #'+workspace/switch-to-4
   :g "s-6" #'+workspace/switch-to-5
   :g "s-7" #'+workspace/switch-to-6
   :g "s-8" #'+workspace/switch-to-7
   :g "s-9" #'+workspace/switch-to-8
   :g "s-0" #'+workspace/switch-to-final

   (:leader
     (:prefix "q"
       :desc "Close current window"
       "w" #'+workspace/close-window-or-workspace))))

;; Projectile

(add-hook! projectile-mode
  (when (eq projectile-indexing-method 'alien)
    (setq projectile-enable-caching nil))

  ; set default folder to projectile load projects
  (setq projectile-project-search-path (list (getenv "CODE_HOME")))

  (map!
   (:map projectile-mode
     (:leader
       (:prefix "p"
         :desc "Open test or implementation in another window"
         :n "A" #'projectile-find-implementation-or-test-other-window)))))

;; Elisp

(add-hook! emacs-lisp-mode
  (map!
   (:map emacs-lisp-mode-map
     (:localleader
       "e" nil ; unmap macroexpand
       "x" #'macrostep-expand
       (:prefix ("e" . "eval")
         "b" #'eval-buffer)))))

;; Lispyville

(add-hook! clojure-mode #'lispyville-mode)
(add-hook! emacs-lisp-mode #'lispyville-mode)

(after! lispyville
  (lispyville-set-key-theme
   '(operators
     prettify
     text-objects
     (atom-motions t)
     commentary
     slurp/barf-cp
     additional
     additional-insert))

  (map!
   (:map lispyville-mode-map
     :m "(" #'lispyville-left
     :m ")" #'lispyville-right
     "M-h" #'lispyville-beginning-of-defun
     "M-l" #'lispyville-end-of-defun)))

;; Clojure mappings

(add-hook! clojure-mode
  (map!
   (:map clojure-mode-map
     :n "gd" #'cider-find-var
     (:localleader
       (:prefix ("e" . "eval")
         "b" #'cider-load-buffer
         "n" #'cider-eval-ns-form
         "c" #'cider-read-and-eval-defun-at-point
         "f" #'cider-eval-sexp-at-point)
       (:prefix ("t" . "test")
         "t" #'cider-test-run-test
         "n" #'cider-test-run-ns-tests
         "p" #'cider-test-run-project-tests)
       (:prefix ("n" . "namespace")
         "r" #'cider-ns-refresh
         "R" #'cider-ns-reload)
       (:prefix ("r" . "repl")
         "s" #'cider-jack-in)
       (:prefix ("c" . "code")
         "a" #'clojure-align)))))
