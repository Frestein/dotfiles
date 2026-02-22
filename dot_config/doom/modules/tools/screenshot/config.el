;;; tools/screenshot/config.el -*- lexical-binding: t; -*-

(use-package! screenshot
  :hook (screenshot-buffer-creation . g-screenshot-on-buffer-creation)
  :config
  (setq screenshot-line-numbers-p t)
  (setq screenshot-min-width 80)
  (setq screenshot-max-width 300)
  (setq screenshot-truncate-lines-p nil)
  (setq screenshot-text-only-p nil)
  (setq screenshot-font-family "Maple Mono NF")
  (setq screenshot-font-size 10)
  (setq screenshot-border-width 16)
  (setq screenshot-radius 10)
  (setq screenshot-shadow-intensity 90)
  (setq screenshot-shadow-radius 16)
  (setq screenshot-shadow-offset-horizontal 8)
  (setq screenshot-shadow-offset-vertical 8))
