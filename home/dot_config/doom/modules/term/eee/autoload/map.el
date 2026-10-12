;;; term/eee/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/eee--init-map-h ()
  "Initialize eee's mappings."
  (map! :leader
        (:prefix "f"
         :desc "Open directory in yazi" "M" #'ee-yazi)))
