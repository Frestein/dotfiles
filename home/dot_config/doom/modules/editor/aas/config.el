;;; editor/aas/config.el -*- lexical-binding: t; -*-

(use-package! aas
  :hook (text-mode . aas-activate-for-major-mode)
  :hook (org-mode . aas-activate-for-major-mode)
  :config
  (aas-set-snippets 'text-mode
    ";а" (string ?а ?\u0301) ; а́
    ";е" (string ?е ?\u0301) ; е́
    ";и" (string ?и ?\u0301) ; и́
    ";о" (string ?о ?\u0301) ; о́
    ";у" (string ?у ?\u0301) ; у́
    ";ы" (string ?ы ?\u0301) ; ы́
    ";э" (string ?э ?\u0301) ; э́
    ";ю" (string ?ю ?\u0301) ; ю́
    ";я" (string ?я ?\u0301) ; я́
    "<<" "«"
    ">>" "»"
    :cond (lambda ()
            (not (and (derived-mode-p 'org-mode)
                      (or (org-in-src-block-p)
                          (org-in-verbatim-emphasis)))))
    "--" "—"))
