;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; TODO: https://github.com/minad/jinx/issues/261
(unpin! compat)

(package! once)

(when (and (modulep! :tools lsp +eglot)
           (modulep! :lang python +lsp))
  (package! eglot-python-preset))

(when (modulep! :editor evil +vimrc)
  (package! vimrc-mode))

(when (modulep! :term eshell)
  (when (modulep! :completion company)
    (package! esh-autosuggest))

  (when (executable-find "atuin")
    (package! eshell-atuin))

  (when (modulep! :term vterm)
    (package! eshell-vterm)))

(when (modulep! :lang org)
  (package! org-expose-emphasis-markers)
  (package! org-edna)
  (package! corg)

  (when (modulep! :lang org +contacts)
    (package! org-contacts))

  (when (modulep! :lang org +super)
    (package! org-super-agenda))

  (when (modulep! :lang org +roam)
    (package! org-roam-ui)

    (when (modulep! :completion vertico)
      (package! consult-org-roam))

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
