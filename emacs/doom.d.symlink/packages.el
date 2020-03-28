;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! lispyville) ;; Awesome package to work with Lisp code
(package! exec-path-from-shell) ;; GUI Emacs does not load PATH var env properly (Mac issue)

(when (featurep! :checkers syntax)
  (package! flycheck-clj-kondo)) ;; clj-kondo integration


(package! lsp-ui :disable t) ;; Disable lsp-ui because it is really slow
