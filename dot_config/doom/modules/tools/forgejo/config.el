;;; app/forgejo/config.el -*- lexical-binding: t; -*-

(use-package! fj
  :config
  (setq fj-host "https://codeberg.org"
        fj-user "Frestein"
        fj-token-use-auth-source nil)

  (add-hook 'doom-init-ui-hook
            (lambda ()
              (setq fj-token (auth-source-pass-get 'secret "work/git/codeberg.org/api/fj.el")))))
