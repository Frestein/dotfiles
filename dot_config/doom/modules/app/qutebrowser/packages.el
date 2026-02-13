;; -*- no-byte-compile: t; -*-
;;; app/qutebrowser/packages.el

(when (eq window-system 'x)
  (package! qutebrowser
    :recipe (:host github
             :repo "lrustand/qutebrowser.el"
             :files (:defaults "*.py"))))
