;;; tools/trashed/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/trashed--init-map-h ()
  "Initialize trashed's mappings."
  (map! :leader
        (:prefix "f"
         :desc "Open trash can" "t" #'trashed)))
