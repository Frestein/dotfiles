;;; app/ement/config.el -*- lexical-binding: t; -*-

(use-package! ement
  :commands ement-connect
  :config
  (setq! ement-sessions-file (concat doom-cache-dir "ement.el"))
  (setq! ement-save-sessions t)
  (setq! ement-room-send-message-filter #'ement-room-send-org-filter))
