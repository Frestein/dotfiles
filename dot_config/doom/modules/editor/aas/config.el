;;; editor/aas/config.el -*- lexical-binding: t; -*-

(use-package! aas
  :hook (text-mode . aas-activate-for-major-mode)
  :hook (org-mode . aas-activate-for-major-mode)
  :config
  (aas-set-snippets 'text-mode
                    "--" "—"
                    "<<" "«"
                    ">>" "»"))
