;; -*- no-byte-compile: t; -*-
;;; tools/ebuku/packages.el

(when (executable-find "buku")
  (package! ebuku))
