;;; tools/daemons/doctor.el -*- lexical-binding: t; -*-

(when (modulep! +systemd)
  (unless (executable-find "systemctl")
    (warn! "Couldn't find the systemd.")))
