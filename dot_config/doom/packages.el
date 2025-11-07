;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(when (modulep! :lang org)
  (package! org-super-agenda)
  (package! org-expose-emphasis-markers)
  ;; TODO: Adjust when this is added to GNU ELPA
  (package! org-contacts
    :recipe (:host github :repo "emacsmirror/org-contacts"))
  (package! corg
    :recipe (:host github :repo "isamert/corg.el")))

(when (modulep! :tools magit)
  (when (modulep! :ui hl-todo)
    (package! magit-todos)))

(when (modulep! :config default +gnupg)
  (package! pinentry))
