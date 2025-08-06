;;; editor/drag-stuff/config.el -*- lexical-binding: t; -*-

(use-package! drag-stuff
  :hook ((prog-mode conf-mode org-mode text-mode) . drag-stuff-mode)
  :config
  (map! :map drag-stuff-mode-map
        :n "M-h" #'drag-stuff-left
        :n "M-j" #'drag-stuff-down
        :n "M-k" #'drag-stuff-up
        :n "M-l" #'drag-stuff-right
        :v "M-j" #'drag-stuff-down
        :v "M-k" #'drag-stuff-up))
