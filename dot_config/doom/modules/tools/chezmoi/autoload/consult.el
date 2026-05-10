;;; tools/chezmoi/autoload/consult.el -*- lexical-binding: t; -*-
;;;###if (modulep! :completion vertico)

;;;###autoload
(defun fr/chezmoi-ripgrep ()
  "Perform a ripgrep search in the chezmoi source directory."
  (interactive)
  (unless (file-directory-p fr/chezmoi-dir)
    (user-error "Chezmoi directory doesn't exist (%s)" (abbreviate-file-name fr/chezmoi-dir)))
  (consult-ripgrep fr/chezmoi-dir))
