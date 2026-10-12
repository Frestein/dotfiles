;;; checkers/jinx/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/jinx--init-map-h ()
  "Initialize jinx's mappings."
  (map! :leader
        (:prefix "o"
         :desc "Jinx mode" "j" #'jinx-mode)))
