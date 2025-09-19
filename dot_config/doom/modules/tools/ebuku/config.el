;;; tools/ebuku/config.el -*- lexical-binding: t; -*-

(use-package! ebuku
  :hook (ebuku-mode . (lambda () (evil-snipe-local-mode -1)))
  :config
  (setq ebuku-database-path
        (cond
         ((eq system-type 'windows-nt)
          (substitute-in-file-name "%APPDATA%\\gosuki\\gosuki.db"))
         ((getenv "XDG_DATA_HOME")
          (substitute-in-file-name "$XDG_DATA_HOME/gosuki/gosuki.db"))
         ((getenv "HOME")
          (substitute-in-file-name "$HOME/.local/share/gosuki/gosuki.db"))
         (t "./gosuki.db"))))
