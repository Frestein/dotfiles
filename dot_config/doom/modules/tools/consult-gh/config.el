;;; tools/consult-gh/config.el -*- lexical-binding: t; -*-

(use-package! consult-gh
  :after consult)

(use-package! consult-gh-embark
  :after consult-gh
  :config
  (consult-gh-embark-mode +1))
