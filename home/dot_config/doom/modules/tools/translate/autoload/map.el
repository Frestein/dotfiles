;;; tools/translate/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +gt--init-map-h ()
  "Initialize gt's mappings."
  (map! :leader
        (:prefix ("T" . "translate")
         :desc "Setup translator" "s" #'gt-setup
         :desc "Choose preset" "c" #'gt-switch-translator
         :desc "Translate" "t" #'gt-translate)))
