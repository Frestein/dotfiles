;; -*- no-byte-compile: t; -*-
;;; editor/symex/packages.el

(package! symex-core
  :recipe (:host github
           :repo "drym-org/symex.el"
           :files ("symex-core/symex*.el")))

(package! symex
  :recipe (:host github
           :repo "drym-org/symex.el"
           :files ("symex/symex*.el" "symex/doc/*.texi" "symex/doc/figures")))

(when (modulep! :editor evil)
  (package! symex-evil
    :recipe (:host github
             :repo "drym-org/symex.el"
             :files ("symex-evil/symex*.el")))

  (package! enhanced-evil-paredit))

(when (modulep! +ide)
  (package! symex-ide
    :recipe (:host github
             :repo "drym-org/symex.el"
             :files ("symex-ide/symex*.el"))))

(when (modulep! +rigpa)
  (package! symex-rigpa
    :recipe (
             :host github
             :repo "drym-org/symex.el"
             :files ("symex-rigpa/symex*.el"))))
