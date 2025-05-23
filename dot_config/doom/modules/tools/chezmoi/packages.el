;; -*- no-byte-compile: t; -*-
;;; config/chezmoi/packages.el

(package! chezmoi)

(when (modulep! :completion corfu)
  (package! chezmoi-cape
    :recipe
    (:host github
     :repo "tuh8888/chezmoi.el"
     :branch "main"
     :files ("extensions/chezmoi-cape.el"))))
