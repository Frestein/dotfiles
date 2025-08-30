;;; editor/ialign/config.el -*- lexical-binding: t; -*-

(use-package! ialign)

(map! :map evil-normal-state-map
      "ga" #'ialign)
