;;; app/ement/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/ement--init-map-h ()
  "Initialize ement's mappings."
  (map! :leader
        (:prefix "A"
                 (:prefix ("e" . "ement")
                          "c" #'ement-connect
                          "l" #'ement-room-list
                          "v" #'ement-room-view))))
