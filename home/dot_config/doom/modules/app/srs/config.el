;;; app/srs/config.el -*- lexical-binding: t; -*-

(use-package! org-srs
  :after org)

(use-package! org-srs
  :after org
  :when (eq system-type 'android)
  :custom
  (org-srs-item-confirm #'org-srs-item-confirm-command)
  :config
  (org-srs-ui-mode t))

(add-hook! doom-after-modules-config #'fr/srs--init-map-h)
