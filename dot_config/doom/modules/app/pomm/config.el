;;; app/pomm/config.el -*- lexical-binding: t; -*-

(use-package pomm
  :hook (doom-after-init . pomm-mode-line-mode)
  :config
  (setq alert-default-style 'libnotify))
