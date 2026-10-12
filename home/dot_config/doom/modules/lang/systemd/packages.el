;; -*- no-byte-compile: t; -*-
;;; lang/systemd/packages.el

;; TODO: Adjust when PR will be merged.
;; https://github.com/holomorph/systemd-mode/pull/23
(package! systemd
  :recipe (:host github
           :repo "dadinn/systemd-mode"))
