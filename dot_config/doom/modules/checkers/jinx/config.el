;;; checkers/jinx/config.el -*- lexical-binding: t; -*-

(use-package! jinx
  :hook ((prog-mode conf-mode org-mode text-mode) . drag-stuff-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages))
  :config
  (setq jinx-languages "ru_RU en_US"
        jinx-delay 1.0)

  (after! vertico-multiform
    (add-to-list 'vertico-multiform-categories
                 '(jinx (vertico-grid-annotate . 25)))))
