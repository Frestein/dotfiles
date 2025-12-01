;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(when (modulep! :lang org)
  (package! org-expose-emphasis-markers)

  (package! corg
    :recipe (:host github :repo "isamert/corg.el"))

  ;; TODO: Adjust when this is added to GNU ELPA
  (when (modulep! :lang org +contacts2)
    (package! org-contacts
      :recipe (:host github :repo "emacsmirror/org-contacts")))

  (when (modulep! :lang org +super)
    (package! org-super-agenda)))

(when (modulep! :tools magit)
  (when (modulep! :ui hl-todo)
    (package! magit-todos)))

(when (modulep! :config default +gnupg)
  (package! pinentry))
