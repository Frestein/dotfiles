;;; editor/aas/config.el -*- lexical-binding: t; -*-

(use-package! aas
  :hook (text-mode . aas-activate-for-major-mode)
  :hook (org-mode . aas-activate-for-major-mode)
  :config
  (aas-set-snippets 'text-mode
    "<<" "«"
    ">>" "»"
    :cond (lambda ()
            (not (and (derived-mode-p 'org-mode)
                      (or (org-in-src-block-p)
                          (org-in-verbatim-emphasis)))))
    "--" "—"))
