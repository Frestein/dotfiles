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
          :items ,#'zoxide-query)
        "Zoxide directory source for `consult-dir'.")

      (add-to-list 'consult-dir-sources 'consult-dir--source-zoxide)))

  (when (modulep! :term eshell)
    (after! eshell
      (advice-add 'eshell-add-to-dir-ring :after #'zoxide-add)

      (defun eshell/zi (&rest targets)
        "`eshell/cd' with interactive zoxide selection, sorted by score.
The whole database is queried when TARGETS is nil."
        (when-let ((matches (apply #'zoxide--scored-query targets))
                   (col (+ 10
                           (cl-loop for (path . _) in matches
                                    maximize (string-width path)))))
          (let ((completion-extra-properties
                 `(:annotation-function
                   ,(lambda (cand)
                      (concat
                       (propertize " " 'display `(space :align-to (+ left ,col)))
                       (cdr (assoc cand matches)))))))
            (eshell/cd
             (completing-read "Zoxide: "
                              (completion-table-with-metadata
                               (mapcar #'car matches)
                               '((display-sort-function . identity)))
                              nil t)))))

      (defun eshell/z (&rest targets)
        "Change directory using zoxide, falling back to cd.
If TARGETS is nil, go to $HOME."
        (let ((home (or (getenv "HOME") "~")))
          (cond
           ((null targets)
            (eshell/cd home))
           ((and (null (cdr targets))
                 (file-directory-p (expand-file-name (car targets))))
            (eshell/cd (expand-file-name (car targets))))
           (t
            (let ((candidate (car (apply #'zoxide-query targets))))
              (if candidate
                  (eshell/cd candidate)
                (error "No match found for %s" (string-join targets " "))))))))

      (defun pcomplete/z ()
        "Completion for the `z' command."
        (let* ((args (cdr pcomplete-args))
               (matches (and (cdr args)
                             (zerop (length pcomplete-stub))
                             (apply #'zoxide-query (butlast args)))))
          (cond
           (matches
            (pcomplete-here (list (completing-read "Zoxide: " matches nil t))))
           ((null (cdr args))
            (pcomplete-here (pcomplete-dirs))))))))
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

  (defadvice! fix/zoxide-run (async &rest args)
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

  (defun zoxide-query (&rest queries)
    "Search zoxide database with QUERIES by calling zoxide query."
    (when-let ((results (apply #'zoxide-run nil "query" "-l" queries)))
      (mapcar #'file-name-as-directory (split-string results "\n" t))))

  (defun zoxide--scored-query (&rest queries)
    "Query the zoxide database with QUERIES, returning an alist.
The alist elements are (PATH . SCORE), sorted by score like
`zoxide query -s -l' prints them."
    (mapcar (lambda (line)
              (let ((fields (split-string line)))
                (cons (string-join (cdr fields) " ")
                      (car fields))))
            (split-string
             (or (apply #'zoxide-run nil "query" "-s" "-l" queries) "")
             "\n" t)))

  (defun zoxide--open-with (query callback &optional noninteractive)
    "Search QUERY and run CALLBACK on the selected path.
CALLBACK is called interactively, or noninteractively with the
selected path as its first argument when NONINTERACTIVE is set."
    (let* ((results (if query (zoxide-query query) (zoxide-query)))
           (default-directory (completing-read "Zoxide: " results nil t)))
      (if (and (not noninteractive) (commandp callback))
          (call-interactively callback)
        (funcall callback default-directory))))

  (defadvice! fix/zoxide-find-file (&optional query)
    "Open file in path from zoxide. If QUERY is given, use it."
    :override #'zoxide-find-file
    (interactive)
    (if query
        (zoxide--open-with query zoxide-find-file-function)
      (zoxide--open-with nil zoxide-find-file-function))))

(add-hook! doom-after-modules-config #'fr/zoxide--init-map-h)
