;; -*- no-byte-compile: t; -*-
;;; term/eee/packages.el

(package! eee
  :recipe (:host github
           :repo "Frestein/eee.el"
           :branch "foot"
           :files (:defaults "*.el" "*.sh")))
