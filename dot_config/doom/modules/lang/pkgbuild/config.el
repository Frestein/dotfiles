;;; lang/pkgbuild/config.el -*- lexical-binding: t; -*-

(defun +pkgbuild-common-config (mode)
  (when (modulep! +lsp)
    (set-eglot-client! mode '("termux-language-server"))
    (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! 'append)))

(use-package! pkgbuild-mode
  :custom
  (pkgbuild-user-mail-address "fresteinart@gmail.com")
  (pkgbuild-makepkg-command "makepkg -si")
  :config
  (+pkgbuild-common-config 'pkgbuild-mode)

  (map! :map pkgbuild-mode-map
        :localleader
        "s" #'pkgbuild-update-srcinfo
        "S" #'pkgbuild-update-sums-line
        "b" #'pkgbuild-makepkg
        "t" #'pkgbuild-tar
        "e" #'pkgbuild-etags
        "i" #'pkgbuild-initialize
        "r" #'pkgbuild-increase-release-tag
        "o" #'pkgbuild-browse-url))
