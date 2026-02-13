;;; app/qutebrowser/config.el -*- lexical-binding: t; -*-

(setq-default browse-url-generic-program (executable-find "qutebrowser"))

(use-package! qutebrowser
  :when (eq window-system 'x)
  :after exwm
  :custom
  (qutebrowser-launcher-backend #'qutebrowser-consult-launcher))
