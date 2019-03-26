;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(after! ivy
        (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy))))
