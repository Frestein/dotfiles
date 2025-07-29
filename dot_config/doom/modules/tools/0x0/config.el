;;; tools/0x0/config.el -*- lexical-binding: t; -*-

(map! :leader
      (:prefix-map ("c" . "code")
       :desc "Pastebin Code" "p" #'0x0-upload-text))

(use-package! 0x0)
