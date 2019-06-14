;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq doom-theme 'doom-one)

;; Disable confirmation message on exit
(setq confirm-kill-emacs nil)

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

;; set emacs to startup with maximized window
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Mouse interaction
(when (eq window-system nil)
    (xterm-mouse-mode t))

;; Lispyville

(add-hook! clojure-mode #'lispyville-mode)
(add-hook! emacs-lisp-mode #'lispyville-mode)

(after! lispyville
  (lispyville-set-key-theme
   '(additional
     commentary
     operators
     slurp/barf-cp))
  (evil-define-key 'normal lispyville-mode-map "(" #'lispyville-left)
  (evil-define-key 'visual lispyville-mode-map "(" #'lispyville-left)
  (evil-define-key 'normal lispyville-mode-map ")" #'lispyville-right)
  (evil-define-key 'visual lispyville-mode-map ")" #'lispyville-right))

;; cider

(add-hook! cider-mode
  (evil-define-key 'normal cider-mode-map "gd" #'cider-find-var)
  (evil-define-key 'normal cider-mode-map "cP" #'cider-eval-buffer)
  (evil-define-key 'normal cider-mode-map "cpp" #'cider-eval-sexp-at-point))

;; Modeline

(setq doom-modeline-persp-name t) ;; Shows project name in modeline

;; Windows

(map!
 ; Select windows
 :m "C-h" #'evil-window-left
 :m "C-l" #'evil-window-right
 :m "C-j" #'evil-window-down
 :m "C-k" #'evil-window-up
 ; Move windows
 :m "C-S-h" #'+evil/window-move-left
 :m "C-S-j" #'+evil/window-move-down
 :m "C-S-k" #'+evil/window-move-up
 :m "C-S-l" #'+evil/window-move-right)

;; Workspaces

(map! (:when (featurep! :ui workspaces)
        :n "`n"  #'+workspace/switch-right
        :n "`p"  #'+workspace/switch-left
        :n "`x"  #'+workspace/close-window-or-workspace
        :g "s-1" #'+workspace/switch-to-0
        :g "s-2" #'+workspace/switch-to-1
        :g "s-3" #'+workspace/switch-to-2
        :g "s-4" #'+workspace/switch-to-3
        :g "s-5" #'+workspace/switch-to-4
        :g "s-6" #'+workspace/switch-to-5
        :g "s-7" #'+workspace/switch-to-6
        :g "s-8" #'+workspace/switch-to-7
        :g "s-9" #'+workspace/switch-to-8
        :g "s-0" #'+workspace/switch-to-final))
