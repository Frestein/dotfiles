;;; tools/ebuku/config.el -*- lexical-binding: t; -*-

(use-package! ebuku
  :when (or (executable-find "buku")
            (executable-find "suki"))
  :config
  (setopt ebuku-database-path
          (cond
           ((getenv "XDG_DATA_HOME")
            (substitute-in-file-name "$XDG_DATA_HOME/gosuki/gosuki.db"))
           ((getenv "HOME")
            (substitute-in-file-name "$HOME/.local/share/gosuki/gosuki.db"))
           ((eq system-type 'windows-nt)
            (substitute-in-file-name "%APPDATA%\\gosuki\\gosuki.db"))
           (t "./gosuki.db"))))
