;;; tools/reader/config.el -*- lexical-binding: t; -*-

(use-package! reader
  :hook (reader-mode . (lambda () (hl-line-mode 0))))
