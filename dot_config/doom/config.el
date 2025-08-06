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
(map! :map evil-normal-state-map
      "H" #'previous-buffer
      "L" #'next-buffer)

(map!
 (:when (modulep! :term vterm )
   :desc "Toggle vterm popup" :n "C-/" #'+vterm/toggle))

(map! :leader
      (:prefix ("A" . "app")
               (:when (modulep! :app rss)
                 :desc "Elfeed" :n "e" #'elfeed))
      (:prefix ("f" . "file")
               (:when (modulep! :emacs dired)
                 :desc "Open directory in dirvish" :n "m" #'dirvish)))

;; Dired
(setq delete-by-moving-to-trash t)
(setq dired-mouse-drag-files t)
(setq mouse-drag-and-drop-region-cross-program t)

;; Dirvish
(after! dirvish
  (setq dirvish-quick-access-entries
        '(("h" "~/"                                 "Home")
          ("d" "~/Downloads/"                       "Downloads")
          ("D" "~/Documents/"                       "Documents")
          ("v" "~/Videos/"                          "Videos")
          ("m" "~/Music/"                           "Music")
          ("c" "~/.config/"                         "Config")
          ("C" "~/.local/share/chezmoi/dot_config/" "Dotfiles")
          ("p" "~/Pictures/"                        "Pictures")
          ("P" "~/Projects/"                        "Projects")
          ("M" "/mnt/"                              "Drives")
          ("t" "~/.local/share/Trash/files/"        "TrashCan")))

  (setq dirvish-attributes
        '(collapse git-msg file-modes file-time))

  (setq dirvish-side-attributes
        '(collapse))

  (when (modulep! :emacs dired +icons)
    (setq dirvish-subtree-always-show-state t)
    (cl-callf append dirvish-attributes '(nerd-icons))
    (cl-callf append dirvish-side-attributes '(nerd-icons)))

  (when (modulep! :ui vc-gutter)
    ;; The vc-gutter module uses `diff-hl-dired-mode' + `diff-hl-margin-mode'
    ;; for diffs in dirvish buffers. `vc-state' uses overlays, so they won't be
    ;; visible in the terminal.
    (when (or (daemonp) (display-graphic-p))
      (push 'vc-state dirvish-side-attributes)))

  (dirvish-define-preview eza (file)
    "Use `eza' to generate directory preview."
    :require ("eza")
    (when (file-directory-p file)
      `(shell . ("eza" "-al" "--group" "--group-directories-first" ,file))))

  (push 'eza dirvish-preview-dispatchers)

  (setq mouse-1-click-follows-link nil)
  (map! :map dirvish-mode-map
        :n "<mouse-1>" #'dirvish-subtree-toggle-or-open
        :n "<mouse-2>" #'dired-mouse-find-file-other-window
        :n "<mouse-3>" #'dired-mouse-find-file
        :n "g" #'dirvish-quick-access)

  (dirvish-peek-mode t))

;; Git
;; Magit
(after! magit
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
