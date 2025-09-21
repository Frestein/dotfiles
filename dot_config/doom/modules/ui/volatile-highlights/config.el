;;; ui/volatile-highlights/config.el -*- lexical-binding: t; -*-

(use-package volatile-highlights
  :hook (doom-after-init . volatile-highlights-mode)
  :config
  (setq vhl/animation-style 'pulse)

  (when (modulep! :editor evil)
    (vhl/define-extension 'evil 'evil-paste-after 'evil-paste-before
                          'evil-paste-pop)
    (vhl/install-extension 'evil)))
