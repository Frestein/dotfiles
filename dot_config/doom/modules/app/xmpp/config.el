;;; app/xmpp/config.el -*- lexical-binding: t; -*-

(use-package! jabber
  :config
  ;; Hide credentials
  (when (modulep! :completion vertico)
    (after! marginalia
      (setopt marginalia-censor-variables
              (list
               (concat
                (car marginalia-censor-variables)
                "\\|^jabber-account-list$"))))))
