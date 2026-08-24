;;; checkers/jinx/doctor.el -*- lexical-binding: t; -*-

(unless (executable-find "enchant-2")
  (warn! "Couldn't find the enchant binary."))
