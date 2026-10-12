;;; tools/consult-gh/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/consult-gh--init-map-h ()
  "Initialize consult-gh's mappings."
  (map! :leader
        (:prefix "A"
         :desc "GitHub" "g" #'consult-gh)))
