;; -*- no-byte-compile: t; -*-
;;; app/forgejo/packages.el

(package! fj
  :recipe (:host codeberg :repo "martianh/fj.el"
           :files ("*.el")))
