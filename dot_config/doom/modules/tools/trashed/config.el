;;; tools/trashed/config.el -*- lexical-binding: t; -*-

(map! (:leader
       (:prefix ("A" . "app")
         :desc "Trashed" "T" #'trashed)))

(use-package! trashed
  :bind ("C-c T" . trashed))
