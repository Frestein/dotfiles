;; -*- no-byte-compile: t; -*-
;;; tools/consult-gh/packages.el

(when (modulep! :completion vertico)
  (package! consult-gh)

  (package! consult-gh-embark
    :recipe (:host github :repo "armindarvish/consult-gh"
             :files ("consult-gh-embark.el"))))
