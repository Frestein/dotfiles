;;; tools/tldr/doctor.el -*- lexical-binding: t; -*-

(unless (executable-find "unzip")
  (warn! "Couldn't find the unzip binary."))
