;;; app/osm/config.el -*- lexical-binding: t; -*-

(use-package! osm
  :bind ("C-c m" . osm-prefix-map)
  :custom
  (osm-server 'default)
  (osm-copyright t))
