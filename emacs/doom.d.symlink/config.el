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
