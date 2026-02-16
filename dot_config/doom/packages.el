;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! once
  :recipe (:host github :repo "meedstrom/once"))

(when (modulep! :term eshell)
  (package! esh-autosuggest)

  (when (executable-find "atuin")
    (package! eshell-atuin))

  (when (modulep! :term vterm)
    (package! eshell-vterm)))

(when (modulep! :lang org)
  (package! org-expose-emphasis-markers)

  (package! corg
    :recipe (:host github :repo "isamert/corg.el"))

  ;; TODO: Adjust when doomelpa will be synced
  ;; https://github.com/orgs/doomemacs/discussions/68
  (when (modulep! :lang org +contacts2)
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
