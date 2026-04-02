;;; editor/symex/config.el -*- lexical-binding: t; -*-

(use-package! symex-core
  :hook (doom-first-file . symex-core-mode))

(use-package! symex
  :after symex-core
  :hook (symex-core-mode . symex-mode)
  :config
  (map! :in "M-S" #'symex-mode-interface))

(use-package! symex-evil
  :after (symex evil)
  :when (modulep! :editor evil)
  :hook (symex-mode . symex-evil-mode))

(use-package! symex-ide
  :after symex
  :when (modulep! +ide)
  :hook (symex-mode . symex-ide-mode))

(use-package! paredit
  :hook ((emacs-lisp-mode . paredit-mode)
         (ielm-mode . paredit-mode)
         (eval-expression-minibuffer-setup . paredit-mode)
         (lisp-mode . paredit-mode)
         (lisp-interaction-mode . paredit-mode)
         (scheme-mode . paredit-mode))
  :config
  (map! :map paredit-mode-map
        "<return>" #'fr/paredit-RET)

  (defun fr/paredit-RET ()
    "Wraps `paredit-RET' to provide a sensible minibuffer experience."
    (interactive)
    (if (minibufferp)
        (read--expression-try-read)
      (paredit-RET))))

(use-package! enhanced-evil-paredit
  :hook (paredit-mode . enhanced-evil-paredit-mode))
