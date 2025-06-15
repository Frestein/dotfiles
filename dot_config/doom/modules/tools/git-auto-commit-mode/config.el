;;; tools/git-auto-commit-mode/config.el -*- lexical-binding: t; -*-

(use-package! git-auto-commit-mode
  :custom
  (gac-automatically-push-p t)
  (gac-debounce-interval 120))
