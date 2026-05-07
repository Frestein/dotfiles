;;; tools/trashed/config.el -*- lexical-binding: t; -*-

(setopt delete-by-moving-to-trash t)

(use-package! trashed
  :config
  (setopt trashed-buffer-name "*Trash Can*")
  (setopt trashed-action-confirmer 'y-or-n-p)

  (set-popup-rule! "^\\*Trash Can"
    :actions '(fr/+popup-display-dynamic-side)
    :slot 20 :height 0.5 :width 0.5 :select t :modeline t :quit 'other :ttl 0)

  (map! :map trashed-mode-map
        [return] #'trashed-view-file
        [S-return] #'trashed-find-file))
