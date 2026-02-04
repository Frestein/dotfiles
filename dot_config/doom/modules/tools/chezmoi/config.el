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
