;; -*- no-byte-compile: t; -*-
;;; app/telega/packages.el

(package! telega)

(when (modulep! +mnz)
  (package! language-detection))

(when (modulep! +icons)
  (package! telega-url-shorten-nerd
    :recipe (:host codeberg :repo "Frestein/telega-url-shorten-nerd")))
