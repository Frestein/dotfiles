;;; tools/emureader/config.el -*- lexical-binding: t; -*-

(use-package! emureader
  :config
  (setq emureader-directory
        (expand-file-name "straight/repos/emureader" doom-local-dir))
  :hook (emureader-mode . (lambda () (hl-line-mode 0))))
