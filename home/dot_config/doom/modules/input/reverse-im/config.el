;;; editor/reverse-im/config.el -*- lexical-binding: t; -*-

(use-package! char-fold
  :custom
  (char-fold-symmetric t)
  (search-default-mode #'char-fold-to-regexp))

(use-package! reverse-im
  :after char-fold
  :bind ("M-W" . reverse-im-translate-word)
  :hook (doom-after-init . reverse-im-mode)
  :custom
  (reverse-im-cache-file (locate-user-emacs-file "reverse-im-cache.el"))
  (reverse-im-read-char-include-commands
   '(org-capture
     org-export-dispatch
     org-agenda
     y-or-n-p
     yes-or-no-p
     map-y-or-n-p
     read-answer
     "^mu4e-.*"))
  (reverse-im-char-fold t)
  (reverse-im-read-char-advice-function #'reverse-im-read-char-include)
  (reverse-im-input-methods (list default-input-method)))
