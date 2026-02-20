;;; app/calibre/config.el -*- lexical-binding: t; -*-

(use-package! calibredb
  :config
  (setopt calibredb-root-dir "~/Documents/calibre/")
  ;; For folder driver metadata: it should be .metadata.calibre
  (setopt calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setopt calibredb-library-alist '(("~/Documents/calibre"))))
