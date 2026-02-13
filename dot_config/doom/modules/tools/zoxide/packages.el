;; -*- no-byte-compile: t; -*-
;;; tools/zoxide/packages.el

(when (executable-find "zoxide")
  (package! zoxide))
