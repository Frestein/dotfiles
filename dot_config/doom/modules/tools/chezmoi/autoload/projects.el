;;; tools/chezmoi/autoload/projects.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +chezmoi-browse-dotfiles ()
  "Browse the files in `chezmoi-dir' using `doom-project-browse'."
  (interactive)
  (unless (file-directory-p chezmoi-dir)
    (user-error "$CHEZMOIROOT doesn't exist (%s)" (abbreviate-file-name chezmoi-dir)))
  (doom-project-browse chezmoi-dir))

;; TODO: Dubious shit.
;;;###autoload
(defun +chezmoi-projectile-find-file ()
  "Browse the files in `chezmoi-dir' using `projectile-find-file'."
  (interactive)
  (projectile-switch-project-by-name chezmoi-dir)
  (call-interactively #'projectile-find-file))
