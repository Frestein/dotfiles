;;; tools/gpg/config.el -*- lexical-binding: t; -*-

(setq epg-pinentry-mode 'loopback
      epg-gpg-home-directory (getenv "GNUPGHOME"))

(use-package! pinentry
  :hook (doom-after-init . pinentry-start))
