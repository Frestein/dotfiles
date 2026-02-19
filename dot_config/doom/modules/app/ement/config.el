;;; app/ement/config.el -*- lexical-binding: t; -*-

(use-package! ement
  :config
  (setq ement-sessions-file (expand-file-name "ement.el" doom-cache-dir))
  (setq ement-save-sessions t)
  (setq ement-room-send-message-filter #'ement-room-send-org-filter))
