;;; tools/screenshot/config.el -*- lexical-binding: t; -*-

(use-package! screenshot
  :hook (screenshot-buffer-creation-hook . g-screenshot-on-buffer-creation)
  :config
  (setq screenshot-line-numbers-p t
        screenshot-min-width 80
        screenshot-max-width 300
        screenshot-truncate-lines-p nil
        screenshot-text-only-p nil
        screenshot-font-family "Maple Mono NF"
        screenshot-font-size 10
        screenshot-border-width 16
        screenshot-radius 10
        screenshot-shadow-intensity 90
        screenshot-shadow-radius 16
        screenshot-shadow-offset-horizontal 8
        screenshot-shadow-offset-vertical 8))
