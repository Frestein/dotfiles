;;; checkers/jinx/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/jinx--init-map-h ()
  "Initialize jinx's mappings."
  (map! :leader
        (:prefix "t"
         :desc "Jinx mode" "j" #'jinx-mode)))
