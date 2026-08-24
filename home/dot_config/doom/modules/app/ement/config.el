;;; app/ement/config.el -*- lexical-binding: t; -*-

(use-package! ement
  :config
  (setopt ement-sessions-file (expand-file-name "ement.el" doom-cache-dir))
  (setopt ement-save-sessions t)
  (setopt ement-room-send-message-filter #'ement-room-send-org-filter)
  (setq ement-notify-dbus-p nil))
