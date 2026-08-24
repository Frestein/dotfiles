;;; tools/chezmoi/autoload/projects.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/chezmoi-browse-dotfiles ()
  "Browse the files in `fr/chezmoi-dir' using `doom-project-browse'."
  (interactive)
  (unless (file-directory-p fr/chezmoi-dir)
    (user-error "Chezmoi directory doesn't exist (%s)" (abbreviate-file-name fr/chezmoi-dir)))
  (doom-project-browse fr/chezmoi-dir))

;; TODO: Dubious shit. I don't remember what I wanted from this function.
;;;###autoload
(defun fr/chezmoi-projectile-find-file ()
  "TODO
Browse the files in `fr/chezmoi-dir' using `projectile-find-file'."
  (interactive)
  (projectile-switch-project-by-name fr/chezmoi-dir)
  (call-interactively #'projectile-find-file))
