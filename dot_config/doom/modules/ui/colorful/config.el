;;; ui/colorful/config.el -*- lexical-binding: t; -*-

(use-package! colorful-mode
  :hook (doom-after-init . global-colorful-mode)
  :config
  (add-to-list 'global-colorful-modes 'conf-mode)
  (add-to-list 'colorful-extra-color-keyword-functions
               '(conf-mode . colorful-add-color-names))
  (when (modulep! :lang emacs-lisp)
    (add-to-list 'global-colorful-modes 'helpful-mode)
    (add-to-list 'colorful-extra-color-keyword-functions
                 '(helpful-mode . colorful-add-color-names)))
  :custom-face (colorful-base ((nil (:box nil)))))
