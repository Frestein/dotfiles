;; -*- no-byte-compile: t; -*-
;;; app/qutebrowser/packages.el

(package! qutebrowser
  :recipe (:host github
           :repo "lrustand/qutebrowser.el"
           :files (:defaults "*.py")))
