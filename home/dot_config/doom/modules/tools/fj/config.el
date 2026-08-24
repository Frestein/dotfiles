;;; tools/fj/config.el -*- lexical-binding: t; -*-

(use-package! fj
  :config
  ;; Hide credentials
  (when (modulep! :completion vertico)
    (after! marginalia
      (setopt marginalia-censor-variables
              (list
               (concat
                (car marginalia-censor-variables)
                "\\|^fj-token$"))))))
