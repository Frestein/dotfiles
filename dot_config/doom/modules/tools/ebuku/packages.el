;; -*- no-byte-compile: t; -*-
;;; tools/ebuku/packages.el

(when (or (executable-find "buku")
          (executable-find "suki"))
  (package! ebuku))
