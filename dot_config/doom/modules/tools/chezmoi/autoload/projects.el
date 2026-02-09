;;; tools/chezmoi/autoload/projects.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +chezmoi-browse-dotfiles ()
  "Browse the files in `chezmoi-dir'."
  (interactive)
  (unless (file-directory-p chezmoi-dir)
    (user-error "$CHEZMOIROOT doesn't exist (%s)" (abbreviate-file-name chezmoi-dir)))
  (doom-project-browse chezmoi-dir))
