;;; ui/frames-ony/config.el -*- lexical-binding: t; -*-

(use-package! frames-only-mode
  :hook (doom-after-init . frames-only-mode)
  :config
  (when (modulep! +remap)
    (frames-only-mode-remap-common-window-split-keybindings)))
