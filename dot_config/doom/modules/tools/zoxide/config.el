;;; tools/zoxide/config.el -*- lexical-binding: t; -*-

(use-package! zoxide
  :init
  (add-hook! find-file #'zoxide-add)

  (after! projectile
    (add-hook! projectile-after-switch-project #'zoxide-add))

  (when (modulep! :completion vertico)
    (after! consult-dir
      (defvar consult-dir--source-zoxide
        `(:name "Zoxide"
          :narrow ?z
          :category file
          :face consult-file
          :history file-name-history
          :enabled ,(lambda () (executable-find "zoxide"))
          :items ,#'zoxide-query)
        "Zoxide directory source for `consult-dir'.")

      (pushnew! consult-dir-sources 'consult-dir--source-zoxide)))

  (when (modulep! :term eshell)
    (after! eshell
      (advice-add 'eshell-add-to-dir-ring :after #'zoxide-add)

      (defun eshell/zi ()
        "cd with interactive selection."
        (zoxide-find-file))

      (defun eshell/z (&optional target)
        "Change eshell directory using zoxide; if TARGET nil/empty, cd to $HOME."
        (let* ((res (if (and target (not (string-empty-p target)))
                        (with-temp-buffer
                          (call-process "zoxide" nil t nil "query" target)
                          (s-trim (buffer-string)))
                      nil)))
          (if (and res (not (string-empty-p res)))
              (eshell/cd res)
            (eshell/cd (or (getenv "HOME") "~"))))))))
