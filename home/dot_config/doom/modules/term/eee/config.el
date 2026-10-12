;;; term/eee/config.el -*- lexical-binding: t; -*-

(use-package! eee
  :config
  (setopt ee-terminal-command "footclient"))

(add-hook! doom-after-modules-config #'fr/eee--init-map-h)
