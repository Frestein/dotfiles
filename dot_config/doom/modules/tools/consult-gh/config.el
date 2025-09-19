;;; tools/consult-gh/config.el -*- lexical-binding: t; -*-

(use-package! consult-gh
  :after consult
  :custom
  (consult-gh-default-clone-directory "~/Projects/git")
  (consult-gh-show-preview t)
  (consult-gh-preview-key "C-o")
  (consult-gh-group-dashboard-by :reason)
  :config
  ;; Remember visited orgs and repos across sessions
  (add-to-list 'savehist-additional-variables 'consult-gh--known-orgs-list)
  (add-to-list 'savehist-additional-variables 'consult-gh--known-repos-list))

(use-package! consult-gh-embark
  :when (modulep! +embark)
  :after (consult-gh embark embark-consult)
  :config
  (consult-gh-embark-mode t))

(use-package! consult-gh-nerd-icons
  :when (modulep! +nerd)
  :after consult-gh
  :config
  (consult-gh-nerd-icons-mode t))

(use-package! consult-gh-transient
  :after consult-gh
  :custom
  (consult-gh-default-interactive-command #'consult-gh-transient))
