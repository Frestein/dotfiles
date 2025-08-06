;;; tools/trashed/config.el -*- lexical-binding: t; -*-

(setq delete-by-moving-to-trash t)

(use-package! trashed
  :bind ("C-c T" . trashed))

(map! (:leader
       (:prefix ("A" . "app")
        :desc "Trashed" :n "T" #'trashed)))
