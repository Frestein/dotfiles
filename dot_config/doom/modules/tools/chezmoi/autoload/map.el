;;; tools/chezmoi/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +chezmoi--init-h ()
  "Initialize chezmoi"
  (map! :leader
        (:prefix "s"
         :desc "Find file in dotfiles" "z" #'chezmoi-find
         :desc "Browse dotfiles" "Z" #'+chezmoi--browse-dotfiles)))
