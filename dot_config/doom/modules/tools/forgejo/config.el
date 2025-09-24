;;; app/forgejo/config.el -*- lexical-binding: t; -*-

(use-package! fj
  :config
  (setq fj-host "https://codeberg.org"
        fj-user "Frestein"
        fj-token-use-auth-source nil)

  (defun frestein/fj-set-token ()
    (setq fj-token (auth-source-pass-get 'secret "work/git/codeberg.org/api/fj.el")))

  (if (daemonp)
      (add-hook! server-after-make-frame (frestein/fj-set-token))
    (add-hook! doom-init-ui (frestein/fj-set-token))))
