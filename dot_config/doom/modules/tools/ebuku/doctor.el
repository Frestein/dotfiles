;;; tools/ebuku/doctor.el -*- lexical-binding: t; -*-

(unless (executable-find "buku")
  (warn! "Couldn't find the buku binary."))
