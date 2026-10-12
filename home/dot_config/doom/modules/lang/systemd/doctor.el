;;; lang/systemd/doctor.el -*- lexical-binding: t; -*-

(unless (executable-find "systemctl")
  (warn! "Couldn't find the systemd."))
