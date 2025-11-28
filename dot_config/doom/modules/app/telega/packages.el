;; -*- no-byte-compile: t; -*-
;;; app/telega/packages.el

(package! telega :pin "c8000bb5a9549297d51bf95f24056b44990d1ecc")

(when (modulep! +mnz)
  (package! language-detection))

(when (modulep! +icons)
  (package! telega-url-shorten-nerd
    :recipe (:host codeberg :repo "Frestein/telega-url-shorten-nerd")))
