;;; tools/git-auto-commit/config.el -*- lexical-binding: t; -*-

(use-package! git-auto-commit-mode
  :custom
  (gac-debounce-interval 600)
  (gac-automatically-push-p t)
  (gac-silent-message-p t)
  :config
  (setopt gac-default-message
          (lambda (filename)
            (concat "Update " (gac-relative-file-name filename))))

  ;; TODO: Adjust when PR will be merged.
  ;; https://github.com/ryuslash/git-auto-commit-mode/pull/49
  (defadvice! fixed-gac-relative-file-name (filename)
    "Find the path to FILENAME relative to its git directory."
    :override #'gac-relative-file-name
    (let* ((default-directory (file-name-directory (expand-file-name filename)))
           (git-dir
            (string-trim-right
             (shell-command-to-string "git rev-parse --show-toplevel"))))
      (file-relative-name filename git-dir))))
