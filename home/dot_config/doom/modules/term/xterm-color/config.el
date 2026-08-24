;;; term/xterm-color/config.el -*- lexical-binding: t; -*-

(use-package! xterm-color
  :config
  (setq compilation-environment '("TERM=xterm-256color"))

  (define-advice compilation-filter (:around (f proc string) xterm-color)
    (funcall f proc (xterm-color-filter string))))
