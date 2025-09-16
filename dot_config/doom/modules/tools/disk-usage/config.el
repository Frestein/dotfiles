;;; tools/disk-usage/config.el -*- lexical-binding: t; -*-

(use-package! disk-usage
  :hook (disk-usage-mode . display-line-numbers-mode))
