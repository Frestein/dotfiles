;;; checkers/jinx/config.el -*- lexical-binding: t; -*-

(use-package! jinx
  :hook (doom-init-ui . global-jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages))
  :config
  (setq jinx-languages "ru_RU en_US"
        jinx-delay 0.2
        global-jinx-modes
        (append
         global-jinx-modes
         '(org-mode)
         (when (modulep! :app telega) '(telega-chat-mode))))

  (after! vertico-multiform
    (add-to-list 'vertico-multiform-categories
                 '(jinx (vertico-grid-annotate . 25)))))

(when (modulep! :app telega)
  (add-hook 'telega-chat-mode-hook #'jinx-mode))
