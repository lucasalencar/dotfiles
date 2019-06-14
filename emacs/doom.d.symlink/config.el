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

;; font
(setq doom-font (font-spec :family "Hack" :size 13)
      doom-big-font-increment 4
      doom-unicode-font (font-spec :family "DejaVu Sans"))

;; hl-fill-column
(add-hook! hl-fill-column-mode
  (set-face-attribute 'hl-fill-column-face nil
                      :background (doom-color 'red)
                      :foreground (doom-color 'fg)))

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

;; Workspaces + Projectile

(map! (:when (featurep! :ui workspaces)
        :n "`n"  #'+workspace/switch-right ; next workspace (tmux like)
        :n "`p"  #'+workspace/switch-left ; previous workspace (tmux like)
        :n "`x"  #'+workspace/close-window-or-workspace ; close current workspace (tmux like)
        :g "s-1" #'+workspace/switch-to-0 ; switch workspaces by index
        :g "s-2" #'+workspace/switch-to-1
        :g "s-3" #'+workspace/switch-to-2
        :g "s-4" #'+workspace/switch-to-3
        :g "s-5" #'+workspace/switch-to-4
        :g "s-6" #'+workspace/switch-to-5
        :g "s-7" #'+workspace/switch-to-6
        :g "s-8" #'+workspace/switch-to-7
        :g "s-9" #'+workspace/switch-to-8
        :g "s-0" #'+workspace/switch-to-final
        :n "`1"  #'+workspace/switch-to-0 ; switch workspaces by index (tmux like)
        :n "`2"  #'+workspace/switch-to-1
        :n "`3"  #'+workspace/switch-to-2
        :n "`4"  #'+workspace/switch-to-3
        :n "`5"  #'+workspace/switch-to-4
        :n "`6"  #'+workspace/switch-to-5
        :n "`7"  #'+workspace/switch-to-6
        :n "`8"  #'+workspace/switch-to-7
        :n "`9"  #'+workspace/switch-to-8))

; set default folder to projectile load projects
(setq projectile-project-search-path (list (getenv "CODE_HOME")))

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

;; Clojure mappings

(map! (:map clojure-mode-map
        (:localleader
          (:prefix ("e" . "eval")
            "b" #'cider-load-buffer
            "n" #'cider-eval-ns-form
            "c" #'cider-read-and-eval-defun-at-point))))
