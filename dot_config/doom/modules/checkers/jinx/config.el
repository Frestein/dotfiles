;;; checkers/jinx/config.el -*- lexical-binding: t; -*-

(use-package! jinx
  :hook (doom-init-ui . global-jinx-mode)
  :bind (("C-M-$" . jinx-languages)
         ([remap ispell-word] . #'jinx-correct))
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
                 '(jinx (vertico-grid-annotate . 25))))

  (after! evil-commands
    (global-set-key [remap evil-next-flyspell-error] #'jinx-next)
    (global-set-key [remap evil-prev-flyspell-error] #'jinx-previous))

  ;; I prefer for `point' to end up at the start of the word,
  ;; not just after the end.
  (advice-add 'jinx-next :after (lambda (_) (left-word))))
