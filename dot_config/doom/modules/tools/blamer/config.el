;;; tools/blamer/config.el -*- lexical-binding: t; -*-

(use-package! blamer
  :config
  (setq blamer-idle-time 0.4
        blamer-max-lines 0
        blamer-commit-formatter "- %s"
        blamer-min-offset nil)

  (custom-set-faces!
    `(blamer-face :foreground ,(doom-color 'comments) :italic true)))
