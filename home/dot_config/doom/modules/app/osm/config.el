;;; app/osm/config.el -*- lexical-binding: t; -*-

(use-package! osm
  :config
  (setopt osm-copyright nil))

(add-hook! doom-after-modules-config #'fr/osm--init-map-h)
