;;; tools/screenshot/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/screenshot--init-map-h ()
  "Initialize screenshot's mappings."
  (map! :leader
        (:prefix "c"
         :desc "Screenshot code" "S" #'screenshot)))
