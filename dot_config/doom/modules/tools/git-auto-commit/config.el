;;; tools/git-auto-commit/config.el -*- lexical-binding: t; -*-

(use-package! git-auto-commit-mode
  :custom
  (gac-debounce-interval 600)
  (gac-automatically-push-p t)
  (gac-silent-message-p t)
  :config
  (setq gac-default-message
        (lambda (filename)
          (concat "Update " (gac-relative-file-name filename))))

  ;; INFO: fix https://github.com/ryuslash/git-auto-commit-mode/pull/49
  (defun gac-relative-file-name (filename)
    "Find the path to FILENAME relative to its git directory."
    (let* ((default-directory (file-name-directory (expand-file-name filename)))
           (git-dir
            (string-trim-right
             (shell-command-to-string "git rev-parse --show-toplevel"))))
      (file-relative-name filename git-dir))))
