;;; tools/consult-gh/config.el -*- lexical-binding: t; -*-

(use-package! consult-gh
  :after-call consult)

(use-package! consult-gh-embark
  :when (modulep! +embark)
  :after-call (consult-gh embark embark-consult)
  :config
  (consult-gh-embark-mode t))

(use-package! consult-gh-nerd-icons
  :when (modulep! +nerd)
  :after-call consult-gh
  :config
  (consult-gh-nerd-icons-mode t))
