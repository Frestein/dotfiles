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

;; Org
(setq org-directory "~/Documents/org/")

;; Global Auto Revert
;; A buffer can get out of sync with respect to its visited file on disk if that file is changed by another program. To keep it up to date, you can enable Auto Revert mode by typing M-x auto-revert-mode, or you can set it to be turned on globally with ‘global-auto-revert-mode’.  I have also turned on Global Auto Revert on non-file buffers, which is especially useful for ‘dired’ buffers.
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t)

;; Line numbers
(setq display-line-numbers-type 'relative)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; Shell
(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shel "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")

;; Smooth scroll
;; Disable ultra-scroll
(remove-hook 'doom-first-input-hook #'ultra-scroll-mode)
(remove-hook 'doom-first-file-hook #'ultra-scroll-mode)

;; Mappings
(map! (:leader
       (:prefix ("A" . "app")
                (:when (modulep! :app rss)
                  :desc "Elfeed" "e" #'elfeed))))

;; Git
;; Magit
(after! magit
  (setq magit-repository-directories
        '(("~/Projects/" . 2)
          ("~/.local/share/chezmoi" . 1))))
