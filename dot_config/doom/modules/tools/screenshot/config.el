;;; tools/screenshot/config.el -*- lexical-binding: t; -*-

(map! :leader
      (:prefix-map ("c" . "code")
       :desc "Screenshot Code" "S" #'screenshot))
