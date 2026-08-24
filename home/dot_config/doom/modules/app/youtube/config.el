;;; app/youtube/config.el -*- lexical-binding: t; -*-

(use-package! yeetube
  :config
  (setopt yeetube-download-directory (concat (xdg-user-dir "DOWNLOAD") "/yeetube"))
  (setq yeetube-invidious-instances '("inv.nadeko.net"))
  (setq-default yeetube-mpv-video-quality "1080"))

(add-hook! doom-after-modules-config #'fr/yeetube--init-map-h)
