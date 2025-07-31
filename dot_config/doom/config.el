;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Set `compile-angel-verbose' to nil to disable compile-angel messages.
;; (When set to nil, compile-angel won't show which file is being compiled.)
(setq compile-angel-verbose nil)

;; Uncomment the line below to compile automatically when an Elisp file is saved
;; (add-hook 'emacs-lisp-mode-hook #'compile-angel-on-save-local-mode)

;; A global mode that compiles .el files before they are loaded
;; using `load' or `require'.
(compile-angel-on-load-mode)

;; User
(setq user-full-name "Frestein"
      user-mail-address "frestein@tuta.io")

;; Theme
(setq doom-theme 'doom-gruvbox)

;; Global Auto Revert
;; A buffer can get out of sync with respect to its visited file on disk if that file is changed by another program. To keep it up to date, you can enable Auto Revert mode by typing M-x auto-revert-mode, or you can set it to be turned on globally with ‘global-auto-revert-mode’.  I have also turned on Global Auto Revert on non-file buffers, which is especially useful for ‘dired’ buffers.
(global-auto-revert-mode t)
(setq global-auto-revert-non-file-buffers t)

;; Line settings
(setq display-line-numbers-type 'relative)
(visual-line-mode t)

;; Fonts
(setq doom-font (font-spec :family "Maple Mono NF" :size 14)
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 14)
      doom-big-font (font-spec :family "Maple Mono NF" :size 24)
      doom-symbol-font (font-spec :family "JoyPixels" :size 14)
      doom-serif-font (font-spec :family "Noto Serif" :size 14))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; Shell
(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shel "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")

;; Smooth scroll
;; Disable ultra-scroll
(remove-hook 'doom-first-input-hook #'ultra-scroll-mode)
(remove-hook 'doom-first-file-hook #'ultra-scroll-mode)

;; Mappings
(map! :leader
      (:prefix ("A" . "app")
               (:when (modulep! :app rss)
                 :desc "Elfeed"
                 "e" #'elfeed)))

;; Git
;; Magit
(when (modulep! :tools magit)
  (setq magit-repository-directories
        '(("~/Projects/" . 2)
          ("~/.local/share/chezmoi" . 1))))

;; Org
(after! org
  (setq org-directory "~/Documents/org/"
        org-hide-emphasis-markers t))

;; Zen
(when (modulep! :ui zen)
  (setq +zen-text-scale 0
        writeroom-width 100))
