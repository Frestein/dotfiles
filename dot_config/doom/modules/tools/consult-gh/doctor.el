;;; tools/consult-gh/doctor.el -*- lexical-binding: t; -*-

(unless (modulep! :completion vertico)
  (warn! "This module requires (:completion vertico)."))

(unless (modulep! :lang markdown)
  (warn! "This module requires (:lang markdown)."))

(unless (executable-find "gh")
  (warn! "Couldn't find the GitHub CLI binary."))
