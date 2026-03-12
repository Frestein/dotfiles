;;; tools/chezmoi/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +chezmoi--init-map-h ()
  "Initialize chezmoi's mappings."
  (after! dired
    (map! :map dired-mode-map
          :localleader
          "c" nil
          (:prefix ("c" . "chezmoi")
           :desc "Add marked" "a" #'chezmoi-dired-add-marked-files
           :desc "Re-add marked" "A" #'+chezmoi-dired-re-add-marked-files)))

  (map! :leader
        (:prefix ("C" . "chezmoi")
         :desc "Find file in dotfiles" "f" #'chezmoi-find
         :desc "Browse dotfiles" "F" #'+chezmoi--browse-dotfiles
         :desc "Sync file" "w" #'chezmoi-write
         :desc "Sync files" "W" #'chezmoi-sync-files
         :desc "Show status" "s" #'+chezmoi-status
         :desc "Show diff" "d" #'chezmoi-diff
         :desc "Ediff file" "e" #'chezmoi-ediff
         :desc "Ediff merge file" "E" #'chezmoi-ediff-merge
         :desc "Merge file" "m" #'chezmoi-merge
         :desc "Open source/target" "o" #'chezmoi-open-other
         :desc "Toggle display templates" "t" #'chezmoi-template-buffer-display
         ((:when (modulep! :tools magit))
          :desc "Magit status" "g" #'chezmoi-magit-status))
        (:prefix "s"
         :desc "Find file in dotfiles" "c" #'chezmoi-find
         :desc "Browse dotfiles" "C" #'+chezmoi-browse-dotfiles)))
