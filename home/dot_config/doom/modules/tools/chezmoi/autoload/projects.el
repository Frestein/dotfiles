;;; tools/chezmoi/autoload/projects.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/chezmoi-dominating-file (names &optional dir)
  "Return the nearest of NAMES above DIR within `fr/chezmoi-dir'.

Searches upward from DIR (or `default-directory'), trying each
name at every level, and returns its absolute path, or nil if DIR
lies outside the chezmoi source directory or nothing was found."
  (catch 'found
    (setq dir (file-name-as-directory
               (expand-file-name (or dir default-directory))))
    (while (string-prefix-p fr/chezmoi-dir dir)
      (dolist (name names)
        (let ((candidate (expand-file-name name dir)))
          (when (file-exists-p candidate)
            (throw 'found candidate))))
      (setq dir (file-name-directory (directory-file-name dir))))))

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
