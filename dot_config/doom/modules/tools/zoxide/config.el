;;; tools/zoxide/config.el -*- lexical-binding: t; -*-

(use-package! zoxide
  :when (executable-find "zoxide")
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

      (add-to-list 'consult-dir-sources 'consult-dir--source-zoxide)))

  (when (modulep! :term eshell)
    (after! eshell
      (advice-add 'eshell-add-to-dir-ring :after #'zoxide-add)

      (defun eshell/zi (&optional target)
        "`eshell/cd' with interactive selection."
        (if target (zoxide-find-file target) (zoxide-find-file)))

      (defun eshell/z (&optional target)
        "Change eshell directory using zoxide.
If TARGET nil/empty, `eshell/cd' to $HOME."
        (let ((home (or (getenv "HOME") "~")))
          (if (and target (not (string-empty-p target)))
              (let ((candidate (car (zoxide-query target))))
                (if candidate (eshell/cd candidate) (eshell/cd target)))
            (eshell/cd home))))))
  :config
  (fmakunbound 'zoxide-query)
  (fmakunbound 'zoxide-query-with)
  (fmakunbound 'zoxide-open-with)
  (fmakunbound 'zoxide-find-file-with-query)
  (fmakunbound 'zoxide-cd)
  (fmakunbound 'zoxide-cd-with-query)
  (fmakunbound 'zoxide-travel)
  (fmakunbound 'zoxide-travel-with-query)
  (makunbound  'zoxide-travel-callback-function)

  (defadvice! fixed-zoxide-run (async &rest args)
    "Run zoxide command with args.
The first argument ASYNC specifies whether calling asynchronously or not.
The second argument ARGS is passed to zoxide directly, like `query -l'."
    :override #'zoxide-run
    (if async
        (apply #'start-process "zoxide" "*zoxide*" zoxide-executable args)
      (with-temp-buffer
        (if (equal 0 (apply #'call-process zoxide-executable nil t nil args))
            (string-trim-right (buffer-string))
          (append-to-buffer "*zoxide*" (point-min) (point-max))
          (warn "Zoxide error. See buffer *zoxide* for more details.")))))

  (defun zoxide-query (&optional query)
    "Search zoxide database with QUERY by calling zoxide query."
    (let ((results (if query
                       (zoxide-run nil "query" "-l" query)
                     (zoxide-run nil "query" "-l"))))
      (mapcar #'file-name-as-directory
              (split-string results "\n"))))

  (defun zoxide--open-with (query callback &optional noninteractive)
    "Search QUERY and run CALLBACK function with a selected path.

If NONINTERACTIVE is non-nil, the callback is always called
directly with the selected path as its first argument.

This is a help function to define interactive commands like
`zoxide-find-file'."
    (let* ((results (if query (zoxide-query query) (zoxide-query)))
           (default-directory (completing-read "Zoxide: " results nil t)))
      (if (and (not noninteractive) (commandp callback))
          (call-interactively callback)
        (funcall callback default-directory))))

  (defadvice! fixed-zoxide-find-file (&optional query)
    "Open file in path from zoxide. If QUERY is given, use it."
    :override #'zoxide-find-file
    (interactive)
    (if query
        (zoxide--open-with query zoxide-find-file-function)
      (zoxide--open-with nil zoxide-find-file-function))))
