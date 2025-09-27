;;; ui/colorful/config.el -*- lexical-binding: t; -*-

(use-package! colorful-mode
  :hook (doom-after-init . global-colorful-mode)
  :config
  (add-to-list 'global-colorful-modes 'conf-mode)
  (when (modulep! :lang emacs-lisp)
    (add-to-list 'global-colorful-modes 'helpful-mode))
  :custom-face (colorful-base ((nil (:box nil)))))
