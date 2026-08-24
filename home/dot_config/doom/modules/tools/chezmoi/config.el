;;; tools/chezmoi/config.el -*- lexical-binding: t; -*-

(defcustom fr/chezmoi-dir (file-name-as-directory
                           (string-trim-right (shell-command-to-string "chezmoi source-path")))
  "Location of the chezmoi directory."
  :type '(string)
  :group 'chezmoi)

(defcustom fr/chezmoi-doom-private-dir (concat fr/chezmoi-dir "/dot_config/doom/")
  "Location of the chezmoi managed doom private directory."
  :type '(string)
  :group 'chezmoi
  :set-after '(fr/chezmoi-dir))

(setopt fr/chezmoi-dir
        (if-let* ((dir (getenv "CHEZMOIROOT")))
            (file-name-as-directory dir)
          (file-name-as-directory
           (string-trim-right (shell-command-to-string "chezmoi source-path")))))

(use-package! chezmoi
  :config
  (setopt chezmoi-mode-overwrite-destination t)

  (defcustom chezmoi-pager-command "less"
    "Pager to use for chezmoi commands."
    :type '(string)
    :group 'chezmoi)

  ;; Overridden because `chezmoi managed' inexplicably includes .chezmoiscripts,
  ;; breaking `chezmoi-find' logic.
  (defadvice! fr/chezmoi-managed ()
    "List all files and directories managed by chezmoi."
    :override #'chezmoi-managed
    (thread-last "managed"
                 chezmoi--dispatch
                 (cl-remove-if (lambda (file) (string-prefix-p ".chezmoi" file)))
                 (cl-map 'list (lambda (file) (concat "~/" file)))))

  ;; Helper that collects every file under the chezmoi source directory,
  ;; used by `chezmoi-find' when invoked with a prefix argument.
  (defun chezmoi--all-files ()
    "Return all managed files plus hidden chezmoi config files from source directory."
    (let* ((managed (chezmoi-managed-files))
           (source-files
            (let ((default-directory fr/chezmoi-dir))
              (cl-loop for entry in (file-expand-wildcards ".chezmoi*")
                       for abs = (expand-file-name entry)
                       if (file-regular-p abs)
                       collect (abbreviate-file-name abs)
                       else if (file-directory-p abs)
                       append (mapcar #'abbreviate-file-name
                                      (directory-files-recursively abs ".*" nil))))))
      (delete-dups (append managed source-files))))

  ;; Extended to correctly handle hidden chezmoi files that are frequently
  ;; needed but missing from the original implementation.
  (defadvice! fr/chezmoi-find (file)
    "Edit a source FILE managed by chezmoi.

If the target file has the same state as the source file, add a hook to
`save-buffer' that applies the source state to the target state.  This way, when
the buffer editing the source state is saved the target state is kept in sync.
Note: Does not run =chezmoi edit=.

With a prefix argument (\\[universal-argument]), include hidden chezmoi
configuration files."
    :override 'chezmoi-find
    (interactive
     (list
      (let ((files (if current-prefix-arg
                       (chezmoi--all-files)
                     (chezmoi-managed-files))))
        (chezmoi--completing-read "Select a dotfile to edit: "
                                  files
                                  'project-file))))
    (if (string-prefix-p (expand-file-name fr/chezmoi-dir) (expand-file-name file))
        (find-file file)
      (let ((source-file (chezmoi-source-file file)))
        (when source-file
          (find-file source-file)
          (let ((target-file (expand-file-name file)))
            (when-let ((mode (and (chezmoi--use-template target-file)
				  (assoc-default target-file auto-mode-alist 'string-match))))
	      (let ((final-mode (or (assoc-default mode treesit-major-mode-remap-alist)
				    (assoc-default mode major-mode-remap-alist)
				    (assoc-default mode major-mode-remap-defaults)
				    mode)))
		(funcall
		 (if (and (listp final-mode) (null (car final-mode)))
		     (save-window-excursion
		       (let* ((existed (get-file-buffer target-file))
			      (_ (find-file target-file))
			      (m major-mode))
			 (unless existed (kill-current-buffer))
			 m))
		   final-mode))))
            (message target-file)
            (unless chezmoi-mode (chezmoi-mode))
            source-file)))))

  (defun fr/chezmoi-status (arg)
    "View output of `chezmoi status' in a status-buffer.
If ARG is non-nil, switch to the status-buffer. "
    (interactive "i")
    (let ((b (get-buffer-create "*chezmoi-status*")))
      (with-current-buffer b
        (let ((inhibit-read-only t))
          (erase-buffer)
          (chezmoi--locally
           (shell-command (concat chezmoi-command " status --use-builtin-diff ") b))))
      (unless arg
        (let ((window (display-buffer b '((display-buffer-at-bottom)
                                          (window-height . 0.25)))))
          (select-window window)
          (with-current-buffer b
            (diff-mode)
            (read-only-mode 1)
            (whitespace-mode 0))))
      b))

  ;; I don’t remember why I wrote it.
  (defadvice! fr/chezmoi-diff (arg)
    "View output of `chezmoi diff' in a diff-buffer.
If ARG is non-nil, switch to the diff-buffer."
    :override #'chezmoi-diff
    (interactive "i")
    (let ((b (get-buffer-create "*chezmoi-diff*")))
      (with-current-buffer b
        (let ((inhibit-read-only t))
          (erase-buffer)
          (chezmoi--locally
           (shell-command (concat chezmoi-command " diff --use-builtin-diff "
                                  "--pager " (shell-quote-argument chezmoi-pager-command))
                          b))))
      (unless arg
        (let ((window (display-buffer b
                                      '((display-buffer-pop-up-window)
                                        (window-height . 0.50)))))
          (select-window window)
          (with-current-buffer b
            (diff-mode)
            (read-only-mode 1)
            (whitespace-mode 0))))
      b))

  ;; The original function does not support the --encrypt flag.
  (defadvice! fr/chezmoi-dired-add-marked-files (arg)
    "Add files marked in Dired to source state.
With universal argument ARG, adds `--encrypt' flag."
    :override #'chezmoi-dired-add-marked-files
    (interactive "P")
    (dolist (file (dired-get-marked-files))
      (shell-command (concat chezmoi-command " add "
                             (if arg "--encrypt " "")
                             (shell-quote-argument file)))))

  (defun fr/chezmoi-dired-re-add-marked-files (arg)
    "Re-add files marked in Dired to source state.
With universal argument ARG, adds `--encrypt' flag."
    (interactive "P")
    (dolist (file (dired-get-marked-files))
      (shell-command (concat chezmoi-command " re-add "
                             (if arg "--encrypt " "")
                             (shell-quote-argument file)))))

  (when (modulep! :editor evil)
    (add-hook! chezmoi-mode #'fr/chezmoi--evil-h)))

;; TODO: Does not work
;; https://github.com/tuh8888/chezmoi.el/issues/29#issuecomment-1678028390
(use-package! chezmoi-cape
  :when (modulep! :completion corfu)
  :config
  (add-to-list 'completion-at-point-functions #'chezmoi-capf))

(when (modulep! :editor file-templates)
  (advice-add #'fr/file-templates-in-emacs-dirs-p
              :override #'fr/chezmoi--file-templates-in-emacs-dirs-p-a)
  (advice-add #'fr/file-templates-get-short-path
              :override #'fr/chezmoi--file-templates-get-short-path-a))

(add-hook! doom-after-modules-config #'fr/chezmoi--init-map-h)
