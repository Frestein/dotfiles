;; -*- no-byte-compile: t; -*-
;;; ui/unicode2/packages.el

(package! express
  :recipe (:host github :repo "Frestein/express" :branch "Frestein-patch-1"))

(package! unicode-fonts
  :recipe (:host github :repo "Frestein/unicode-fonts" :branch "fix-cl-lib"))
