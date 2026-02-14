;; -*- no-byte-compile: t; -*-
;;; tools/daemons/packages.el

(package! daemons)

(when (and (modulep! +systemd)
           (executable-find "systemctl"))
  ;; TODO: Adjust when PR will be merged.
  ;; https://github.com/holomorph/systemd-mode/pull/23
  (package! systemd
    :recipe (:host github
             :repo "dadinn/systemd-mode")))
