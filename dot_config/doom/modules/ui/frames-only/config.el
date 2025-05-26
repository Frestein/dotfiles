;;; ui/frames-ony/config.el -*- lexical-binding: t; -*-

(use-package! frames-only-mode
  :config
  (frames-only-mode)

  (when (modulep! +remap)
    (frames-only-mode-remap-common-window-split-keybindings)))
