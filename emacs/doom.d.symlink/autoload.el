;;; ~/.dotfiles/emacs/doom.d.symlink/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun user/clean-ns ()
  "Clean ns but removing breaklines when done by refactor-nrepl."
  (interactive)
  (cljr-clean-ns)
  (goto-char (point-min))
  (while (re-search-forward "\n\s*:as\n\s*" nil t)
    (save-match-data
      (replace-match " :as "))))

;;;###autoload
(defun user/cider-eval-and-run-ns-tests ()
  "Eval and run namespace tests"
  (interactive)
  (cider-load-buffer)
  (cider-test-run-ns-tests t))

;;;###autoload
(defun user/cider-eval-and-run-test ()
  "Eval and run defun at point"
  (interactive)
  (cider-eval-defun-at-point)
  (cider-test-run-test))
