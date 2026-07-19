;;; editor/ripgrep/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +rg--init-map-h ()
  "Initialize rg's mappings."
  (map! :leader
        (:prefix "s"
         :desc "Ripgrep (menu)" "G" #'rg-menu)))
