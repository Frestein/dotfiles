;;; editor/ialign/config.el -*- lexical-binding: t; -*-

(use-package! ialign
  :config
  (map! :map evil-normal-state-map
        "ga" #'ialign))
