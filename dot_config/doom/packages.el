;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(when (modulep! :app rss)
  (package! elfeed-summary))

(when (modulep! :lang org)
  (package! org-super-agenda)
  (package! org-expose-emphasis-markers)
  (package! corg
    :recipe (:host github :repo "isamert/corg.el")))

(when (modulep! :tools magit)
  (when (modulep! :ui hl-todo)
    (package! magit-todos)))

(when (modulep! :config default +gnupg)
  (package! pinentry))
