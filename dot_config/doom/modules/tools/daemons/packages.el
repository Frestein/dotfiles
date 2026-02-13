;; -*- no-byte-compile: t; -*-
;;; tools/daemons/packages.el

(package! daemons)

(when (and (modulep! +systemd)
           (executable-find "systemctl"))
  (package! systemd))
