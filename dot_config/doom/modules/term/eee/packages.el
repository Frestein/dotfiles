;; -*- no-byte-compile: t; -*-
;;; term/eee/packages.el

(package! eee
  :recipe (:host github
           :repo "eval-exec/eee.el"
           :files (:defaults "*.el" "*.sh")))
