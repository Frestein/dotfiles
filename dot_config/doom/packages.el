;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(when (modulep! :app rss)
  (package! elfeed-summary))

(when (modulep! :lang org)
  (package! org-super-agenda)

  (package! corg
    :recipe (:host github :repo "isamert/corg.el")))
