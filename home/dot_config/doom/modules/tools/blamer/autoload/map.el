;;; tools/blamer/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/blamer--init-map-h ()
  "Initialize blamer's mappings."
  (map! :leader
        (:prefix "t"
         :desc "Blamer mode" "B" #'global-blamer-mode)))
