;; -*- no-byte-compile: t; -*-
;;; lang/typst/packages.el

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! typst-ts-mode
    :recipe (:host codeberg
             :repo "meow_king/typst-ts-mode")))

(when (and (modulep! +preview)
           (executable-find "tinymist"))
  (package! typst-preview))
