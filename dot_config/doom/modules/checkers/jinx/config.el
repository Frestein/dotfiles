;;; checkers/jinx/config.el -*- lexical-binding: t; -*-

(use-package! jinx
  :hook ((prog-mode conf-mode org-mode text-mode) . jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages))
  :config
  (setq jinx-languages "ru_RU en_US"
        jinx-delay 0.2)

  (after! vertico-multiform
    (add-to-list 'vertico-multiform-categories
                 '(jinx (vertico-grid-annotate . 25)))))
