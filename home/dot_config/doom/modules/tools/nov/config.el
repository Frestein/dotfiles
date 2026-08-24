;;; tools/nov/config.el -*- lexical-binding: t; -*-

(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setopt nov-save-place-file (concat doom-cache-dir "nov-places")))
