;; -*- no-byte-compile: t; -*-
;;; lang/typst/packages.el

(package! typst-ts-mode
  :recipe (:host codeberg
           :repo "meow_king/typst-ts-mode"))

(when (modulep! +preview)
  (package! typst-preview))
