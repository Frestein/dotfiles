;;; tools/zoxide/doctor.el -*- lexical-binding: t; -*-

(unless (executable-find "zoxide")
  (warn! "Couldn't find the zoxide binary."))
