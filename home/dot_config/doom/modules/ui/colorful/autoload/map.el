;;; ui/colorful/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/colorful--init-map-h ()
  "Initialize colorful's mappings."
  (map! :leader
        (:prefix "t"
         :desc "Colorful mode" "C" #'global-colorful-mode)))
