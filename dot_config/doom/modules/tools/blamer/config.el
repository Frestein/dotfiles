;;; tools/blamer/config.el -*- lexical-binding: t; -*-

(use-package! blamer
  :config
  (setopt blamer-idle-time 0.4)
  (setopt blamer-max-lines 0)
  (setopt blamer-min-offset 0)
  (setopt blamer-commit-formatter "- %s")

  (custom-set-faces!
    `(blamer-face :foreground ,(doom-color 'comments) :italic true)))
