;;; tools/daemons/config.el -*- lexical-binding: t; -*-

(use-package! daemons)

(add-hook! doom-after-modules-config #'fr/daemons--init-map-h)
