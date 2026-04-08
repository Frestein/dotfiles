;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! once)

(when (modulep! :term eshell)
  (package! esh-autosuggest)

  (when (executable-find "atuin")
    (package! eshell-atuin))

  (when (modulep! :term vterm)
    (package! eshell-vterm)))

(when (modulep! :lang org)
  (package! org-expose-emphasis-markers)

  (package! org-edna)

  (package! corg
    :recipe (:host github :repo "isamert/corg.el"))

  (when (modulep! :lang org +contacts)
    (package! org-contacts
      :recipe (:host github :repo "emacsmirror/org-contacts")))

  (when (modulep! :lang org +super)
    (package! org-super-agenda))

  (when (modulep! :lang org +roam)
    (package! org-roam-ui)
    (when (modulep! :lang org +mem)
      (package! org-mem))))

(when (modulep! :tools magit)
  (when (and (modulep! :tools magit +delta)
             (executable-find "delta"))
    (package! magit-delta))

  (when (modulep! :ui hl-todo)
    (package! magit-todos)))

(when (modulep! :config default +gnupg)
  (package! pinentry))
