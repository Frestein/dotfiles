;;; tools/ebuku/doctor.el -*- lexical-binding: t; -*-

(unless (or (executable-find "buku")
            (executable-find "suki"))
  (warn! "Couldn't find the buku or gosuki."))
