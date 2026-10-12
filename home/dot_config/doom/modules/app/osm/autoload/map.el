;;; app/osm/autoload/map.el -*- lexical-binding: t; -*-

;;;###autoload
(defun fr/osm--init-map-h ()
  "Initialize osm's mappings."
  (map! :leader
        (:prefix "A"
         :desc "Osm" "m" #'osm-prefix-map)))
