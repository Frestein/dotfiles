;; -*- no-byte-compile: t; -*-
;;; tools/zoxide/packages.el

(when (executable-find "zoxide")
  (package! zoxide))

(when (modulep! :term eshell)
  (package! eshell-z :disable t))
