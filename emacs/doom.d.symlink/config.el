;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Theme
(setq doom-theme 'doom-one)

;; Disable confirmation message on exit
(setq confirm-kill-emacs nil)

;; Mouse interaction
(when (eq window-system nil)
    (xterm-mouse-mode t))

;; Lispyville

(add-hook! clojure-mode #'lispyville-mode)

(after! lispyville
        (lispyville-set-key-theme
          '(additional
             commentary
             operators
             slurp/barf-cp))
        (evil-define-key 'normal lispyville-mode-map
                         "(" #'lispyville-left)
        (evil-define-key 'visual lispyville-mode-map
                         "(" #'lispyville-left)
        (evil-define-key 'normal lispyville-mode-map
                         ")" #'lispyville-right)
        (evil-define-key 'visual lispyville-mode-map
                         ")" #'lispyville-right))
;; cider

(add-hook! cider-mode
           (evil-define-key 'normal cider-mode-map
                            "gd" #'cider-find-var)
           (evil-define-key 'normal cider-mode-map
                            "cP" #'cider-eval-buffer)
           (evil-define-key 'normal cider-mode-map
                            "cpp" #'cider-eval-sexp-at-point))

;; Modeline

(setq doom-modeline-persp-name t) ;; Shows project name in modeline

;; Workspaces

(map! (:when (featurep! :ui workspaces)
        :n "`n" #'+workspace/switch-right
        :n "`p" #'+workspace/switch-left))
