;; -*- no-byte-compile: t; -*-
;;; tools/reader/packages.el

(package! reader
  :recipe (:host codeberg :repo "divyaranjan/emacs-reader"
  	   :files ("*.el" "render-core.so")
  	   :pre-build ("make" "all")))
