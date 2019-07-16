;;; ~/.dotfiles/emacs/doom.d.symlink/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun user/clean-ns ()
  "(WIP) Clean ns but removing breaklines when done by refactor-nrepl."
  (interactive)
  (cljr-clean-ns)
  (goto-char (point-min))
  (while (re-search-forward "\n\s*:as\n\s*" nil t)
    (save-match-data
      (replace-match " :as "))))
