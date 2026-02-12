;;; term/eat/config.el -*- lexical-binding: t; -*-

(use-package! eat
  :hook (eshell-load . eat-eshell-mode)
  ;; :hook (eshell-load . eat-eshell-visual-command-mode)
  )
