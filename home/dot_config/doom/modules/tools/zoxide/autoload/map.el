;;; tools/zoxide/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/zoxide--init-map-h ()
  "Initialize zoxide's mappings."
  (map! :n "gZ" #'zoxide-find-file)

  (map! :leader
        (:prefix "f"
         :desc "Zoxide" "z" #'zoxide-find-file)))
