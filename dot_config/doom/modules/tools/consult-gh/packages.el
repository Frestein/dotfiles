;; -*- no-byte-compile: t; -*-
;;; tools/consult-gh/packages.el

(package! consult-gh)

(package! consult-gh-transient
  :recipe (:host github
           :repo "armindarvish/consult-gh"
           :files ("consult-gh-transient.el")))

(package! consult-gh-embark
  :recipe (:host github
           :repo "armindarvish/consult-gh"
           :files ("consult-gh-embark.el")))

(when (modulep! :tools magit +forge)
  (package! consult-gh-forge
    :recipe (:host github
             :repo "armindarvish/consult-gh"
             :files ("consult-gh-forge.el"))))

(when (modulep! +icons)
  (package! consult-gh-nerd-icons
    :recipe (:host github
             :repo "armindarvish/consult-gh"
             :files ("consult-gh-nerd-icons.el"))))
