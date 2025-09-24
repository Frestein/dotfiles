;;; tools/git-auto-commit/config.el -*- lexical-binding: t; -*-

(use-package! git-auto-commit-mode
  :custom
  (gac-debounce-interval 600)
  (gac-automatically-push-p t)
  (gac-silent-message-p t)
  (gac-default-message
   (lambda (filename)
     (concat "Update " (gac-relative-file-name filename)))))
