;;; tools/0x0/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/0x0--init-map-h ()
  "Initialize 0x0's mappings."
  (map! :leader
        (:prefix "c"
         :desc "Pastebin code" "p" #'0x0-upload-text)))
