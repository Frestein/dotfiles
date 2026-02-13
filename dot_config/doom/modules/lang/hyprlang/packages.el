;; -*- no-byte-compile: t; -*-
;;; lang/hyprlang/packages.el

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! hyprlang-ts-mode))
