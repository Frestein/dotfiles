;; -*- no-byte-compile: t; -*-
;;; app/telega/packages.el

(package! telega)

(when (modulep! +mnz)
  (package! language-detection))
