;;; app/calibre/config.el -*- lexical-binding: t; -*-

(use-package! calibredb
  :config
  (setq calibredb-root-dir "~/Documents/calibre/")
  ;; For folder driver metadata: it should be .metadata.calibre
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist '(("~/Documents/calibre"))))
