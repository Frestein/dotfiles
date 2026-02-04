;;; tools/chezmoi/config.el -*- lexical-binding: t; -*-

(defcustom chezmoi-dir (string-trim (shell-command-to-string "chezmoi source-path"))
  "Location of the chezmoi directory"
  :type '(string)
  :group 'chezmoi)

(defcustom chezmoi-doom-private-dir (concat chezmoi-dir "/dot_config/doom/")
  "Location of the chezmoi managed doom private directory"
  :type '(string)
  :group 'chezmoi
  :set-after '(chezmoi-dir))

(use-package! chezmoi
  :config
  (defcustom chezmoi-pager-command "less"
    "Pager to use for chezmoi commands."
    :type '(string)
    :group 'chezmoi)

  (defun chezmoi-status (arg)
    "View output of =chezmoi status= in a status-buffer."
    (interactive "i")
    (let ((b (get-buffer-create "*chezmoi-status*")))
      (with-current-buffer b
        (let ((inhibit-read-only t))
          (erase-buffer)
          (chezmoi--locally
           (shell-command (concat chezmoi-command " status --use-builtin-diff ") b))))
      (unless arg
        (let ((window (display-buffer b
                                      '((display-buffer-at-bottom)
                                        (window-height . 0.25)))))
          (select-window window)
          (with-current-buffer b
            (diff-mode)
            (read-only-mode 1)
            (whitespace-mode 0))))
      b))

  (defun chezmoi-diff (arg)
    "View output of =chezmoi diff= in a diff-buffer.
If ARG is non-nil, switch to the diff-buffer."
    (interactive "i")
    (let ((b (get-buffer-create "*chezmoi-diff*")))
      (with-current-buffer b
        (let ((inhibit-read-only t))
          (erase-buffer)
          (chezmoi--locally
           (shell-command (concat chezmoi-command " diff --use-builtin-diff "
                                  "--pager " (shell-quote-argument chezmoi-pager-command)) b))))
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

  (when (modulep! :editor evil)
    (add-hook 'chezmoi-mode-hook #'+chezmoi--evil-h)))

;; TODO: Does not work
;; https://github.com/tuh8888/chezmoi.el/issues/29#issuecomment-1678028390
(use-package! chezmoi-cape
  :when (modulep! :completion corfu)
  :config
  (add-to-list 'completion-at-point-functions #'chezmoi-capf))

(when (modulep! :editor file-templates)
  (advice-add #'+file-templates-in-emacs-dirs-p
              :override #'+chezmoi--file-templates-in-emacs-dirs-p-a)
  (advice-add #'+file-templates-get-short-path
              :override #'+chezmoi--file-templates-get-short-path-a))

(add-hook 'doom-after-modules-config-hook #'+chezmoi--init-h)
