;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! lispyville) ;; Awesome package to work with Lisp code
(package! exec-path-from-shell) ;; GUI Emacs does not load PATH var env properly (Mac issue)
