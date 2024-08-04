;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! lispyville) ;; Awesome package to work with Lisp code

(when (featurep! :checkers syntax)
  (package! flycheck-clj-kondo)) ;; clj-kondo integration

(package! lsp-ui :disable t) ;; Disable lsp-ui because it is really slow

(package! dart-server)
(package! hover :recipe (:host github :repo "ericdallo/hover.el"))
