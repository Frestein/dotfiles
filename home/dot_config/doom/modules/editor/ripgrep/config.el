;;; editor/ripgrep/config.el -*- lexical-binding: t; -*-

(use-package! rg)

(add-hook! doom-after-modules-config #'+rg--init-map-h)
