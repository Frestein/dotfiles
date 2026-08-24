;;; app/qutebrowser/doctor.el -*- lexical-binding: t; -*-

(unless (executable-find "qutebrowser")
  (warn! "Couldn't find the qutebrowser binary."))
