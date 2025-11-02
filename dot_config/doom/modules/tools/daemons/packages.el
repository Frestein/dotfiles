;; -*- no-byte-compile: t; -*-
;;; tools/daemons/packages.el

(package! daemons)

(when (modulep! +systemd)
  (package! systemd))
