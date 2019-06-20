;;; ~/.dotfiles/emacs/doom.d.symlink/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun user/fix-ns ()
  "(WIP) Fix ns breaklines."
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "\n\s*:as\n\s*" nil t)
    (save-match-data
      (replace-match " :as "))))
