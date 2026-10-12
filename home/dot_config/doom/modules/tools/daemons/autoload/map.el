;;; tools/daemons/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/daemons--init-map-h ()
  "Initialize daemons's mappings."
  (map! :leader
        (:prefix "A"
         :desc "Daemons" "d" #'daemons)))
