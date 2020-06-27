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

;;;###autoload
(defun user/evil-window-vsplit-and-move-right ()
  "Creates a vertical split and move focus right"
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1))

;;;###autoload
(defun user/evil-window-split-and-move-down ()
  "Creates a horizontal split and move focus down"
  (interactive)
  (evil-window-split)
  (evil-window-down 1))

;;;###autoload
(defun user/open-terminal-new-vertical-window ()
  "Opens an ansi-term in a new vertical split window"
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1)
  (ansi-term "/bin/zsh"))

;;;###autoload
(defun user/open-terminal-new-workspace ()
  "Opens an ansi-term in a new workspace"
  (interactive)
  (if (+workspace-exists-p "terminal")
      (+workspace-switch "terminal")
    (+workspace/new "terminal")
    (ansi-term "/bin/zsh")))
