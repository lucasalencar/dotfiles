;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq doom-theme 'doom-molokai)

;; font
(setq doom-font (font-spec :family "Hack" :size 13)
      doom-big-font-increment 4
      doom-unicode-font (font-spec :family "DejaVu Sans"))

;; set localleader
(setq doom-localleader-key ",")

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
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "CODE_HOME")) ;; Copy CODE_HOME env var

;; Modeline

;; Whether display buffer encoding.
(setq doom-modeline-buffer-encoding nil)

;; The maximum displayed length of the branch name of version control.
(setq doom-modeline-vcs-max-length 30)

;; disable file size indicator in modeline
(add-hook! 'size-indication-mode-hook
  (setq size-indication-mode nil))

;; Map TAB to call complete
(map!
 :i "TAB" #'+company/complete)

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
     :n "P" #'+workspace/switch-to

     :desc "Create new workspace (tmux like)"
     :n "C" #'counsel-projectile-switch-project

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
       "w" #'+workspace/close-window-or-workspace)

     (:prefix "o"
      :desc "Open term new vertical window"
      "t" #'user/open-terminal-new-vertical-window

      :desc "Open term new workspace"
      "T" #'user/open-terminal-new-workspace)

     (:prefix "w"
      "v" #'user/evil-window-vsplit-and-move-right
      "s" #'user/evil-window-split-and-move-down))))

;; Projectile

(after! projectile
  (when (eq projectile-indexing-method 'alien)
    (setq projectile-enable-caching nil))

  ;; set default folder to projectile load projects
  ;; To refresh project list run: projectile-discover-projects-in-search-path
  (setq projectile-project-search-path (list (getenv "CODE_HOME")))

  (map!
   (:leader
     (:map projectile-mode-map
       (:prefix "p"
         :desc "Open test or implementation in another window"
         "a" #'projectile-find-implementation-or-test-other-window
         :desc "Add new project"
         "A" #'projectile-add-known-project
         :desc "Discover projects in search path"
         "D" #'projectile-discover-projects-in-search-path)))))

;; Dired

(add-hook! dired-mode
  (dired-hide-details-mode t))

(map!
 :n "-" #'dired-jump)

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
     additional-wrap
     additional-insert))

  (map!
   (:map lispyville-mode-map
     :m "(" #'lispyville-left
     :m ")" #'lispyville-right
     "M-h" #'lispyville-beginning-of-defun
     "M-l" #'lispyville-end-of-defun)))

;; clojure-lsp

;; (add-hook! lsp-mode
;;   (map!
;;    (:map lsp-mode-map
;;     (:leader
;;      "clsR" #'lsp-restart-workspace))))

;; Clojure mappings

(add-hook! clojure-mode
  (setq cljr-warn-on-eval nil ;; Stop warning about evaluating whole project
        cider-show-error-buffer 'only-in-repl) ;; Stop opening a buffer with stacktrace

  (setq lsp-file-watch-threshold nil)

  (map!
   (:map clojure-mode-map
     :n "gd" #'lsp-find-definition
     :n "R"  #'hydra-cljr-help-menu/body

     (:localleader
       "a" #'clojure-align

       (:prefix ("e" . "eval") "b" #'cider-load-buffer
         "n" #'cider-eval-ns-form
         "c" #'cider-read-and-eval-defun-at-point
         "f" #'cider-eval-sexp-at-point)

       (:prefix ("t" . "test")
         "t" #'user/cider-eval-and-run-test
         "T" #'cider-test-run-test
         "n" #'user/cider-eval-and-run-ns-tests
         "N" #'cider-test-run-ns-tests
         "p" #'cider-test-run-project-tests)

       (:prefix ("n" . "namespace")
         "r" #'cider-ns-refresh
         "R" #'cider-ns-reload)

       (:prefix ("r" . "repl")
         "s" #'cider-jack-in
         "C" #'cider-connect)

       "c" nil ; unmap to avoid conflict
       (:prefix ("c" . "code")
         "am" #'cljr-add-missing-libspec
         "cn" #'user/clean-ns
         "tf" #'cljr-thread-first-all
         "tl" #'cljr-thread-last-all
         "ua" #'cljr-unwind-all
         "uu" #'cljr-unwind
         "r"  #'lsp-rename
         "cc" #'lsp-clojure-cycle-coll
         "cp" #'lsp-clojure-cycle-privacy
         "il" #'lsp-clojure-introduce-let
         "el" #'lsp-clojure-expand-let
         "ml" #'lsp-clojure-move-to-let
         "is" #'lsp-clojure-inline-symbol)))))

(after! clj-refactor
  (set-lookup-handlers! 'clj-refactor-mode nil))

;; (after! clojure-mode
;;   (add-hook 'after-save-hook #'cider-load-buffer)) ;; Eval buffer after save

;; CIDER

(add-hook! cider-mode
  (map!
   (:map cider-repl-mode-map
     (:localleader
       "k" #'+popup/raise))))

;; clj-kondo

(use-package! flycheck-clj-kondo
  :when (featurep! :checkers syntax)
  :after flycheck)

;; plantuml-mode
;; TODO Add command to save rendered plantuml to a location

(after! plantuml-mode
  ;; https://github.com/skuro/plantuml-mode/issues/70
  ;; By default plantuml-mode uses "--illegal-access=deny" as java arg.
  ;; But this argument is only supported by Java 9.
  ;; I am using Java 8 which caused compatibility issues.
  (setq plantuml-java-args (list "-Djava.awt.headless=true" "-jar"))

  (set-popup-rule! "^\\*PLANTUML" :side 'right :size 0.5)

  (add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))

  (map!
   (:map plantuml-mode-map
    (:localleader
     ("p" #'plantuml-preview)))))

;; Dart: dart-mode / dart-server / lsp-dart

(after! dart-mode
  (setq lsp-dart-sdk-dir "~/sdk-flutter/bin/cache/dart-sdk/")

  (map!
   (:map dart-mode-map
     :n "gd" #'lsp-find-definition
     :n "gD" #'lsp-find-references)))

(use-package! dart-server
  :hook (dart-mode . dart-server)

  :config
  (setq dart-server-format-on-save t))

;; Flutter

(use-package! flutter
  :hook (dart-mode . (lambda ()
                       (when (flutter-test-file-p)
                         (flutter-test-mode)))))

(after! flutter
  (map!
   (:map dart-mode-map
     (:localleader
       (:prefix ("t" . "test")
         "n" #'flutter-test-current-file
         "t" #'flutter-test-at-point
         "p" #'flutter-test-all)))))

(use-package! hover
  :after dart-mode
  :config
  (setq hover-hot-reload-on-save t
        hover-screenshot-path "$HOME/Pictures"))

(after! hover
  (map!
   (:map dart-mode-map
     (:localleader
       (:prefix ("h" . "hover")
         "r" #'hover-run-or-hot-reload
         "R" #'hover-run-or-hot-restart
         "p" #'hover-take-screenshot)))))

(after! projectile
  ;; Consider flutter package file as project root
  ;; Necessary because searching files in big repositories such as mini-meta-repo
  ;; is really slow, because it considers the whole project instead of just
  ;; the package you are working on.
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))

;; load local configuration file if exists
(load! "local.el" "~/.doom.d" t)
