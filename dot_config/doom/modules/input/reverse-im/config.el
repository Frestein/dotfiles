;;; editor/reverse-im/config.el -*- lexical-binding: t; -*-

;; Needed for `:after char-fold' to work
(use-package! char-fold
  :custom
  (char-fold-symmetric t)
  (search-default-mode #'char-fold-to-regexp))

(use-package! reverse-im
  :demand t
  :after char-fold
  :bind
  ("M-T" . reverse-im-translate-word)
  :custom
  (reverse-im-cache-file (locate-user-emacs-file "reverse-im-cache.el"))
  (reverse-im-char-fold t)
  (reverse-im-read-char-advice-function #'reverse-im-read-char-include)
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode t))
